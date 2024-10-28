# Azure WordPress Deployment with Cloud-Init

This project utilizes Terraform to deploy a WordPress application on Azure with a custom cloud-init script. The deployment includes a Linux virtual machine configured to host WordPress, along with the necessary networking infrastructure, security groups, and configurations.

## Overview

The following Azure resources are provisioned by this Terraform configuration:

- **Resource Group**: A logical container for Azure resources.
- **Virtual Network (VNet)**: A network that allows resources to communicate securely.
- **Subnets**: Two subnets within the virtual network:
  - **Subnet A**: (optional for future use).
  - **Subnet B**: For the WordPress VM.
- **Network Security Group (NSG)**: Controls inbound and outbound traffic to the resources.
- **Public IP Address**: Allows external access to the WordPress VM.
- **Linux Virtual Machine**: Hosts the WordPress application and is configured with a cloud-init script to automate installation.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Terraform**: Version 4.0.0 or later. You can download it from [here](https://www.terraform.io/downloads.html).
- **Azure Account**: An Azure account with sufficient permissions to create resources. You can sign up for a free account [here](https://azure.microsoft.com/free/).
- **Azure CLI**: For authentication and management of Azure resources. You can install it by following the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

## Directory Structure

```plaintext
.
├── main.tf               # Main Terraform configuration file
├── variables.tf          # Variable definitions for customization
├── outputs.tf            # Output definitions for resource information
├── wordpress.yml         # Cloud-init script for WordPress setup
└── terraform.tfvars      # Variables file with default values for execution
```

### File Descriptions

- **`main.tf`**: The core Terraform configuration file that defines all the resources to be created in Azure. It includes:
  - Resource groups
  - Virtual networks and subnets
  - Network security groups and rules
  - Network interfaces
  - Public IP addresses
  - Virtual machines configured with cloud-init

- **`variables.tf`**: Contains the variable definitions used throughout the configuration, allowing for parameterization of resource names, locations, sizes, and credentials.

- **`outputs.tf`**: Defines the outputs of the Terraform execution. Outputs are useful for displaying important resource information after deployment, such as public IP addresses or resource IDs.

- **`wordpress.yml`**: This is the cloud-init configuration file. It is executed upon VM initialization to install and configure WordPress and its dependencies automatically.

- **`terraform.tfvars`**: Contains the actual values for the variables defined in `variables.tf`. You can customize this file for different environments or configurations.

## Cloud-Init Script

The `wordpress.yml` file is used to bootstrap the WordPress installation present in same directory

### Key Points of the Cloud-Init Script:

- **Packages Installation**: The script installs necessary packages such as Apache, PHP, and MySQL client.
- **WordPress Download**: Downloads the latest version of WordPress and extracts it to the web server directory.
- **Permissions**: Sets the appropriate permissions for the WordPress directory.
- **Service Restart**: Restarts the Apache service to apply the changes.

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
- **Resource IDs**: IDs of the created resources for further management.

To view the output values, run:
```bash
terraform output
```


- Replace `yourusername` and `your-repo` with your actual GitHub username and repository name.
- You can adjust the content to reflect any additional details or specific configurations used in your project.

This detailed README should help users understand your project, how to deploy it, and the cloud-init configuration for automating the WordPress installation.
