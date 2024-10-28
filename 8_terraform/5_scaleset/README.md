
# Azure WordPress Hosting with Virtual Machine Scale Set - Modular Terraform Setup

This project deploys a WordPress application on Azure using Terraform, utilizing a Virtual Machine Scale Set (VMSS) for scalability and availability. The architecture is modular, separating networking, virtual machines, and VMSS configurations for better organization and management.

## Overview

The setup consists of the following components:

- **Resource Group**: A container for all Azure resources.
- **Networking Module**: Configures virtual networks, subnets, and network security groups.
- **Virtual Machines Module**: Creates and configures Linux virtual machines to host the WordPress application.
- **VMSS Module**: Deploys a scale set of virtual machines to manage load efficiently.

## Prerequisites

Before you begin, ensure you have the following:

- **Terraform**: Version 1.0.0 or later. Download from [here](https://www.terraform.io/downloads.html).
- **Azure Account**: An Azure account with the necessary permissions to create resources. Sign up for a free account [here](https://azure.microsoft.com/free/).
- **Azure CLI**: For managing Azure resources. Install it by following the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

## Directory Structure

```plaintext
.
├── modules/                   # Contains the modules for networking, virtual machines, and VMSS
│   ├── Networking/
│   │   ├── main.tf            # Networking module configuration
│   │   ├── variables.tf       # Variables for networking module
│   │   └── outputs.tf         # Outputs for networking module
│   ├── VirtualMachine/
│   │   ├── main.tf            # Virtual machine module configuration
│   │   ├── variables.tf       # Variables for VM module
│   │   └── outputs.tf         # Outputs for VM module
└── setup/
    ├── main.tf                # Main Terraform configuration
    ├── variables.tf           # Variable definitions
    ├── outputs.tf             # Output definitions
    └── terraform.tfvars       # Variable values
```

### File Descriptions

- **`setup/main.tf`**: The main configuration file orchestrating the deployment of resources and calling the modules for networking and virtual machines, including VMSS.
  
- **`setup/variables.tf`**: Defines variables used in the Terraform configuration, allowing customization for different environments.

- **`setup/outputs.tf`**: Specifies outputs from the deployment, such as resource IDs and public IP addresses.

- **`setup/terraform.tfvars`**: Contains the values for the variables defined in `variables.tf`. Use this file to set specific parameters for your deployment.

- **`modules/Networking/main.tf`**: Defines resources for networking, including virtual networks, subnets, and network security groups.

- **`modules/Networking/variables.tf`**: Contains variable definitions for the networking module.

- **`modules/Networking/outputs.tf`**: Specifies output values for the networking resources created by the module.

- **`modules/VirtualMachine/main.tf`**: Configures the creation of Linux virtual machines for hosting WordPress.

- **`modules/VirtualMachine/variables.tf`**: Contains variable definitions for the virtual machine module.

- **`modules/VirtualMachine/outputs.tf`**: Specifies output values for the virtual machines created by the module.

- **`modules/VirtualMachineScaleSet/main.tf`**: Configures the deployment of a VMSS for scalable and resilient hosting of WordPress.

- **`modules/VirtualMachineScaleSet/variables.tf`**: Contains variable definitions for the VMSS module.

- **`modules/VirtualMachineScaleSet/outputs.tf`**: Specifies output values for the VMSS created by the module.

## Usage

To deploy the WordPress application with a VM Scale Set, follow these steps:

1. **Clone the Repository**:
   Clone this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo/setup
   ```

2. **Initialize Terraform**:
   This command initializes the Terraform working directory and downloads required provider plugins:
   ```bash
   terraform init
   ```

3. **Plan the Deployment**:
   Generate an execution plan that shows what actions Terraform will take to create the resources:
   ```bash
   terraform plan
   ```

4. **Apply the Configuration**:
   Execute the plan and provision the resources in Azure:
   ```bash
   terraform apply
   ```
   When prompted, type `yes` to confirm the deployment.

5. **Access Your WordPress Application**:
   After the deployment is complete, Terraform will output the public IP address of the load balancer for the VMSS. Access your WordPress application by navigating to `http://<public_ip>` in your web browser.

6. **Destroy Resources**:
   To remove all resources created by Terraform, run:
   ```bash
   terraform destroy
   ```
   When prompted, type `yes` to confirm the destruction of resources.

## Variables

Customize the deployment by modifying the variables defined in `variables.tf`. Below are key variables and their descriptions:

| Variable Name                   | Description                                                        | Type   |
|---------------------------------|--------------------------------------------------------------------|--------|
| `resource_group_name`           | The name of the Azure resource group.                             | string |
| `resource_group_location`       | The Azure region for resource deployment (e.g., "East US").       | string |
| `virtual_networks`              | List of virtual network configurations.                           | list   |
| `subnets`                       | List of subnet configurations.                                    | list   |
| `nsgs`                          | List of network security group configurations.                    | list   |
| `linux_vms`                     | List of Linux virtual machine configurations.                     | list   |
| `vmss_config`                   | Configuration settings for the Virtual Machine Scale Set.         | object |

### Example of `variables.tf`

```hcl
variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The Azure region for resource deployment"
  type        = string
}

variable "virtual_networks" {
  description = "List of virtual network configurations"
  type        = list(object({
    name          = string
    address_space = string
  }))
}

variable "subnets" {
  description = "List of subnet configurations"
  type        = list(object({
    name          = string
    address_prefix = string
  }))
}

variable "nsgs" {
  description = "List of network security group configurations"
  type        = list(object({
    name     = string
    location = string
  }))
}

variable "linux_vms" {
  description = "List of Linux virtual machine configurations"
  type        = list(object({
    name               = string
    admin_username     = string
    admin_password     = string
    size               = string
  }))
}

variable "vmss_config" {
  description = "Configuration settings for the Virtual Machine Scale Set"
  type        = object({
    name                = string
    instance_count      = number
    sku                 = string
    admin_username      = string
    admin_password      = string
    os_disk_size_gb     = number
    image_reference      = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  })
}
```

## Outputs

After the configuration is applied, you can view output values defined in `outputs.tf`. Outputs may include:

- **Public IP Address**: The external IP address to access the WordPress application.
- **Resource IDs**: IDs of the created resources for further management.

To view the output values, run:
```bash
terraform output
```

## Important Notes

- **Security**: Ensure that your `admin_password` meets Azure's complexity requirements. Avoid hardcoding sensitive information directly in your Terraform files. Consider using [Terraform Vault Provider](https://registry.terraform.io/providers/hashicorp/vault/latest/docs) for sensitive data management.
- **Customization**: Adjust sizes, regions, and configurations as per your requirements.
- **Scalability**: VMSS allows you to scale the number of instances based on demand. You can update the `instance_count` in your `terraform.tfvars` to change the desired number of VMs in the scale set.

