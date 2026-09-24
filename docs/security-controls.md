# Security Controls

## Purpose

This document summarizes the security decisions implemented in the Terraform configuration and the additional controls required before a real deployment.

## Implemented Controls

### Network Isolation

- Workloads are designed for private subnets.
- Public subnet creation does not automatically assign public IP addresses.
- Public and private subnets use separate route tables.
- Private subnets have no internet route unless NAT gateways are explicitly enabled.

### Ingress Restrictions

The workload security group permits:

- HTTPS from the AWS VPC
- HTTPS from the simulated on-premises network
- SSH only from explicitly approved administrative CIDR blocks

The default approved administrative CIDR list is empty, so SSH ingress is not created by default.

### Egress Restrictions

Workload egress is limited to:

- HTTPS on TCP port 443
- DNS on TCP and UDP port 53 within the VPC

This avoids the common default of allowing unrestricted outbound traffic on all protocols and ports.

### VPN Safety

Site-to-Site VPN resources are disabled by default. When enabled:

- A customer gateway public address must be supplied.
- Static routing advertises only the configured on-premises CIDR.
- Private route tables receive VPN route propagation.
- Generated tunnel secrets may be stored in Terraform state.

Real gateway addresses, tunnel secrets, and workplace network ranges must never be committed to the public repository.

### Logging and Monitoring

Optional VPC Flow Logs provide:

- Accepted and rejected traffic metadata
- Sixty-second aggregation
- Configurable CloudWatch retention
- A dedicated IAM delivery role
- Log-delivery permissions limited to the project log group

Flow Logs are disabled by default to prevent unreviewed logging costs.

### IAM Controls

The monitoring role:

- Trusts only the VPC Flow Logs service.
- Permits log-stream creation and event delivery.
- Does not grant infrastructure-management permissions.
- Is created only when flow logging is enabled.

### Terraform Security

The repository excludes:

- Terraform state and backup state
- Real `.tfvars` files
- Environment files
- AWS configuration and credential files
- Private keys and certificate bundles
- Plans, logs, reports, and generated artifacts

`.terraform.lock.hcl` remains tracked to preserve reviewed provider selections.

## Required Production Enhancements

Before production use:

1. Store Terraform state in an encrypted remote backend.
2. Enable state locking and version recovery.
3. Use short-lived AWS credentials or workload identity.
4. Apply least-privilege permissions to the Terraform execution role.
5. Enable CloudTrail and organization-level security monitoring.
6. Use customer-managed encryption keys where required.
7. Review network CIDRs for overlap.
8. Validate both VPN tunnels and failure behavior.
9. Replace direct SSH administration with AWS Systems Manager where possible.
10. Add automated security scanning and policy enforcement to CI.

## Secret Handling

Never commit:

- AWS access keys
- Session tokens
- VPN pre-shared keys
- Customer gateway addresses from real environments
- Private network inventories
- Terraform state
- Private certificates or keys

If a secret is committed accidentally, removing it from the latest commit is not sufficient. Revoke or rotate it immediately and remove it from repository history through an approved process.

## Validation

Security validation should include:

```powershell
terraform -chdir=terraform fmt -check -recursive
