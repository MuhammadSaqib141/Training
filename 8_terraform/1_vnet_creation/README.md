
# Azure VNet Creation Project


## Overview

This Terraform configuration provisions the following resources in Azure:

- A resource group
- A virtual network
- Two subnets within the virtual network
- A network security group
- A security rule for the network security group

This setup allows for basic network infrastructure to be deployed on Azure.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (version X.X.X or later)
- An Azure account with sufficient permissions to create resources
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (for authentication)

## Directory Structure

```plaintext
.
├── main.tf           # Main Terraform configuration file
├── variables.tf      # Variable definitions
├── outputs.tf        # Output definitions (if applicable)
└── terraform.tfvars  # Variables file with default values
```

### File Descriptions

- `main.tf`: Contains the main configuration for creating the Azure VNet, subnets, and network security group.
- `variables.tf`: Defines the variables used in the Terraform configuration, such as resource names and locations.
- `outputs.tf`: Specifies the output values of the Terraform execution (can be customized).
- `terraform.tfvars`: Contains the variable values for the Terraform configuration (customizable for different environments).

## Usage

To get started with this Terraform project, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Plan the deployment:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

5. To destroy the resources, run:
   ```bash
   terraform destroy
   ```

## Variables

You can customize the configuration by modifying the variables defined in `variables.tf`. Typical variables include:

- `resource_group_name`: The name of the resource group.
- `location`: The Azure region where resources will be deployed (e.g., "East US").
- `vnet_name`: The name of the virtual network.
- `address_space`: The address space for the virtual network (e.g., `["10.0.0.0/16"]`).

Here’s an example of how `variables.tf` might look:

```hcl
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region for resource deployment"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}
```

## Outputs

After applying the configuration, you can access the outputs defined in `outputs.tf`. Although it is currently empty, you may add output values for your use case, such as the VNet ID or Subnet IDs.

To view the output values, run:
```bash
terraform output
```


This README provides a clear guide for users who want to understand and utilize your Terraform VNet creation code effectively.
