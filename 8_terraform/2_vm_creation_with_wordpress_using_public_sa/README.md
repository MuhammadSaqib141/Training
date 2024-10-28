
# Azure WordPress Deployment Project

This project contains Terraform code for deploying a WordPress application on Azure. It provisions two virtual machines: one for hosting the MySQL database and another for the WordPress frontend. The project includes networking infrastructure, security groups, and necessary configurations for a functional WordPress setup.

## Overview

The following Azure resources are provisioned by this Terraform configuration:

- **Resource Group**: A logical container for Azure resources.
- **Virtual Network (VNet)**: A network that allows the resources to communicate securely.
- **Subnets**: Two subnets within the virtual network:
  - **Subnet A**: (optional, if needed for future expansion)
  - **Subnet B**: For the WordPress VM.
- **Network Security Group (NSG)**: Controls inbound and outbound traffic to the resources.
- **Public IP Address**: Allows external access to the WordPress VM.
- **Two Virtual Machines**:
  - **MySQL VM**: Runs the MySQL database server.
  - **WordPress VM**: Hosts the WordPress application.
- **Storage Account**: Stores deployment scripts and assets.
- **Blob Storage**: Contains the WordPress installation script.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Terraform**: Version 4.0.0 or later. You can download it from [here](https://www.terraform.io/downloads.html).
- **Azure Account**: An Azure account with sufficient permissions to create resources. You can sign up for a free account [here](https://azure.microsoft.com/free/).
- **Azure CLI**: For authentication and management of Azure resources. You can install it by following the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

## Directory Structure

```plaintext
.
├── main.tf           # Main Terraform configuration file
├── variables.tf      # Variable definitions for customization
├── outputs.tf        # Output definitions for resource information
└── terraform.tfvars  # Variables file with default values for execution
```

### File Descriptions

- **`main.tf`**: This is the core Terraform configuration file that defines all the resources to be created in Azure. It includes:
  - Resource groups
  - Virtual networks and subnets
  - Network security groups and rules
  - Network interfaces
  - Public IP addresses
  - Virtual machines
  - Storage accounts and blobs
  - Custom script extensions

- **`variables.tf`**: This file contains the variable definitions used throughout the configuration. It allows for parameterization of the resource names, locations, sizes, and credentials.

- **`outputs.tf`**: This file defines the outputs of the Terraform execution. Outputs are useful for displaying important resource information after deployment, such as public IP addresses or resource IDs.

- **`terraform.tfvars`**: This file contains the actual values for the variables defined in `variables.tf`. You can customize this file for different environments or configurations.

## Usage

To get started with this Terraform project, follow these steps:

1. **Clone the Repository**: 
   Clone this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```

2. **Initialize Terraform**: 
   This command initializes the Terraform working directory, downloads the required provider plugins, and prepares the backend:
   ```bash
   terraform init
   ```

3. **Plan the Deployment**: 
   This command creates an execution plan, showing what actions Terraform will take to create the resources:
   ```bash
   terraform plan
   ```

4. **Apply the Configuration**: 
   This command executes the plan and provisions the resources in Azure:
   ```bash
   terraform apply
   ```
   When prompted, type `yes` to confirm the deployment.

5. **Access Your Application**: 
   Once the deployment is complete, Terraform will provide you with the public IP address of the WordPress VM. You can access your WordPress application by navigating to `http://<public_ip>` in your web browser.

6. **Destroy the Resources**: 
   To remove all resources created by Terraform, run the following command:
   ```bash
   terraform destroy
   ```
   When prompted, type `yes` to confirm the destruction.

## Variables

You can customize the deployment by modifying the variables defined in `variables.tf`. Below is a list of key variables and their descriptions:

| Variable Name               | Description                                                             | Type   |
|-----------------------------|-------------------------------------------------------------------------|--------|
| `resource_group_name`       | The name of the Azure resource group to contain the resources.          | string |
| `location`                  | The Azure region for resource deployment (e.g., "East US").            | string |
| `vnet_name`                 | The name of the virtual network.                                        | string |
| `saqib_vnet_subnetA`       | The name of the first subnet (optional).                               | string |
| `saqib_vnet_subnetB`       | The name of the second subnet for the WordPress VM.                    | string |
| `nsg_name`                  | The name of the network security group.                                 | string |
| `nsg_rule_name`             | The name of the NSG rule that allows HTTP traffic.                     | string |
| `admin_username`            | Admin username for the virtual machines.                                | string |
| `admin_password`            | Admin password for the virtual machines (ensure it meets Azure complexity). | string |

### Example of `variables.tf`

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

variable "saqib_vnet_subnetA" {
  description = "The name of the first subnet (optional)"
  type        = string
}

variable "saqib_vnet_subnetB" {
  description = "The name of the second subnet for the WordPress VM"
  type        = string
}

variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
}

variable "nsg_rule_name" {
  description = "The name of the network security rule"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machines"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machines"
  type        = string
}
```

## Outputs

After applying the configuration, you can access the output values defined in `outputs.tf`. Outputs may include:

- **Public IP Address**: The external IP address to access the WordPress application.
- **MySQL VM IP Address**: The internal IP address of the MySQL VM for direct access (if needed).
- **Resource IDs**: IDs of the created resources for further management.

To view the output values, run:
```bash
terraform output
```

## Important Notes

- **Security**: Ensure that your `admin_password` meets Azure's complexity requirements. Avoid hardcoding sensitive information directly in your Terraform files. Consider using [Terraform Vault Provider](https://registry.terraform.io/providers/hashicorp/vault/latest/docs) for sensitive data management.
- **Customization**: Feel free to customize the sizes, regions, and configurations as per your project requirements.
- **Scaling**: For production use, consider deploying your MySQL database in a separate Azure Database for MySQL service for better performance and management.

## Troubleshooting

If you encounter any issues, consider the following steps:

1. Check the output of the `terraform apply` command for any error messages.
2. Ensure that your Azure subscription has sufficient resources and permissions to create the specified resources.
3. Consult the [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) for specific resource configuration options.

## Conclusion

This README provides a comprehensive guide to deploying a WordPress application on Azure using Terraform. Follow the steps and guidelines to successfully set up and manage your Azure resources.
```

### Additional Considerations
- Replace `yourusername` and `your-repo` with your actual GitHub username and repository name.
- You can modify the content to reflect any additional details or specific configurations used in your project.

This detailed README should help users understand your project, how to deploy it, and the various configurations available.
