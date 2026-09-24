# Architecture Diagrams

## Hybrid Connectivity

```mermaid
flowchart TB
    subgraph ONPREM["Simulated On-Premises Environment"]
        CLIENT["Administrative or Application Client"]
        CGW["Customer Gateway"]
        CLIENT --> CGW
    end

    subgraph AWS["AWS Region"]
        VPN["Optional Site-to-Site VPN"]
        VGW["Virtual Private Gateway"]

        subgraph VPC["VPC 10.20.0.0/16"]
            subgraph AZA["Availability Zone A"]
                PUBA["Public Subnet<br/>10.20.10.0/24"]
                PRIVA["Private Subnet<br/>10.20.110.0/24"]
                NATA["Optional NAT Gateway"]
            end

            subgraph AZB["Availability Zone B"]
                PUBB["Public Subnet<br/>10.20.20.0/24"]
                PRIVB["Private Subnet<br/>10.20.120.0/24"]
                NATB["Optional NAT Gateway"]
            end

            SG["Restricted Workload Security Group"]
            FLOW["Optional VPC Flow Logs"]
        end
    end

    CGW -. "Encrypted VPN tunnels" .-> VPN
    VPN -.-> VGW
    VGW -. "Static on-premises route" .-> PRIVA
    VGW -. "Static on-premises route" .-> PRIVB

    PUBA --> NATA
    PUBB --> NATB
    PRIVA -. "Optional outbound access" .-> NATA
    PRIVB -. "Optional outbound access" .-> NATB

    PRIVA --> SG
    PRIVB --> SG
    VPC -. "Traffic metadata" .-> FLOW
```

Solid lines represent internal resource relationships. Dotted lines represent optional features that remain disabled in the default configuration.

## Terraform Module Flow

```mermaid
flowchart LR
    ROOT["Root Configuration"]
    NET["Networking Module"]
    SEC["Security Module"]
    HYB["Hybrid Connectivity Module"]
    MON["Monitoring Module"]

    ROOT --> NET
    NET --> SEC
    NET --> HYB
    NET --> MON
```

The networking module produces the VPC, subnet, and route-table identifiers consumed by the remaining modules.

## Important Boundary

The diagrams represent the intended architecture. They do not prove that resources were deployed. This repository was initialized, formatted, and validated without AWS credentials.
