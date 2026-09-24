# Deployment Safety

## Deployment Status

This repository is a validated portfolio framework. No AWS infrastructure is deployed automatically.

A successful `terraform validate` confirms configuration consistency. It does not confirm AWS permissions, account quotas, costs, connectivity, or runtime behavior.

## Prerequisites

Before planning or applying:

1. Use an authorized AWS sandbox or development account.
2. Confirm the target account and region.
3. Use short-lived credentials or an approved identity role.
4. Configure encrypted remote state with locking and version recovery.
5. Review all environment-specific variable values.
6. Confirm that VPC and on-premises CIDRs do not overlap.
7. Review current AWS pricing and expected recurring charges.
8. Obtain required technical and change approvals.

Never place credentials, real gateway addresses, private network inventories, or VPN secrets in this repository.

## Safe Validation

The following commands do not deploy infrastructure:

```powershell
terraform -chdir=terraform fmt -check -recursive
