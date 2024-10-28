
# Azure WordPress Hosting with MySQL Database - Modular Terraform Setup

This project deploys a WordPress application on Azure using Terraform, including a MySQL database for persistent storage of content and configurations. The architecture is modular, allowing for a clear organization of networking, compute, and database resources.

## Overview

The setup consists of the following components:

- **Resource Group**: A container for all Azure resources.
- **Networking Module**: Configures virtual networks, subnets, public IPs, and network security groups.
- **Virtual Machines Module**: Creates and configures Linux virtual machines to host the WordPress application.
- **Database Module**: Sets up an Azure Database for MySQL to store WordPress data.

## Prerequisites

Before you begin, ensure you have the following:

- **Terraform**: Version 1.0.0 or later. Download from [here](https://www.terraform.io/downloads.html).
- **Azure Account**: An Azure account with the necessary permissions to create resources. Sign up for a free account [here](https://azure.microsoft.com/free/).
- **Azure CLI**: For managing Azure resources. Install it by following the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

## Directory Structure

```plaintext
.
├── modules/                   # Contains the modules for networking, virtual machines, and database
│   ├── Networking/
│   │   ├── main.tf            # Networking module configuration
│   │   ├── variables.tf       # Variables for networking module
│   │   └── outputs.tf         # Outputs for networking module
│   ├── VirtualMachine/
│   │   ├── main.tf            # Virtual machine module configuration
│   │   ├── variables.tf       # Variables for VM module
│   │   └── outputs.tf         # Outputs for VM module
│   └── DB/
│       ├── main.tf            # Database module configuration
│       ├── variables.tf       # Variables for DB module
│       └── outputs.tf         # Outputs for DB module
└── setup/
    ├── main.tf                # Main Terraform configuration
    ├── variables.tf           # Variable definitions
    ├── outputs.tf             # Output definitions
    └── terraform.tfvars       # Variable values
```

### File Descriptions

- **`setup/main.tf`**: The main configuration file orchestrating the deployment of resources and calling the modules for networking, virtual machines, and databases.
  
- **`setup/variables.tf`**: Defines variables used in the Terraform configuration, allowing customization for different environments.

- **`setup/outputs.tf`**: Specifies outputs from the deployment, such as resource IDs and connection strings.

- **`setup/terraform.tfvars`**: Contains the values for the variables defined in `variables.tf`. Use this file to set specific parameters for your deployment.

- **`modules/Networking/main.tf`**: Defines resources for networking, including virtual networks, public IPs, and network security groups.

- **`modules/Networking/variables.tf`**: Contains variable definitions for the networking module.

- **`modules/Networking/outputs.tf`**: Specifies output values for the networking resources created by the module.

- **`modules/VirtualMachine/main.tf`**: Configures the creation of Linux virtual machines for hosting WordPress.

- **`modules/VirtualMachine/variables.tf`**: Contains variable definitions for the virtual machine module.

- **`modules/VirtualMachine/outputs.tf`**: Specifies output values for the virtual machines created by the module.

- **`modules/DB/main.tf`**: Configures the Azure Database for MySQL and its settings.

- **`modules/DB/variables.tf`**: Contains variable definitions for the database module.

- **`modules/DB/outputs.tf`**: Specifies output values for the MySQL database created by the module.

## Usage

To deploy the WordPress application with a MySQL database, follow these steps:

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
   After the deployment is complete, Terraform will output the public IP address of the WordPress application. Access your WordPress application by navigating to `http://<public_ip>` in your web browser.

6. **Database Connection**:
   You can retrieve the MySQL connection details from the output values, including the server name, database name, username, and password.

7. **Destroy Resources**:
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
| `networking_config`             | Configuration for networking resources, including virtual networks, subnets, public IPs, and NSGs. | map    |
| `vm_configs`                    | Configuration for virtual machines, including VM details and network interface assignments. | map    |
| `mysql_config`                  | Configuration settings for the Azure Database for MySQL.         | object |

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

variable "networking_config" {
  description = "Configuration for networking resources"
  type        = map(object({
    virtual_network = object({
      name          = string
      address_space = string
    })
    subnets = list(object({
      name          = string
      address_prefix = string
    }))
    public_ips = list(object({
      name                = string
      allocation_method   = string
    }))
    nsg = object({
      name     = string
      location = string
    })
  }))
}

variable "vm_configs" {
  description = "Configuration for virtual machines"
  type        = map(object({
    subnet_id = string
    public_ip = string
    vm       = object({
      name               = string
      admin_username     = string
      admin_password     = string
      size               = string
    })
    nic = string
  }))
}

variable "mysql_config" {
  description = "Configuration settings for the Azure Database for MySQL"
  type        = object({
    server_name       = string
    administrator_login = string
    administrator_login_password = string
    version           = string
    sku               = object({
      name     = string
      tier     = string
      capacity = number
    })
  })
}
```

## Outputs

After the configuration is applied, you can view output values defined in `outputs.tf`. Outputs may include:

- **Public IP Address**: The external IP address to access the WordPress application.
- **MySQL Connection String**: Connection details for the Azure Database for MySQL, including server name, database name, username, and password.
- **Resource IDs**: IDs of the created resources for further management.

To view the output values, run:
```bash
terraform output
```

## Important Notes

- **Security**: Ensure that your `administrator_login_password` meets Azure's complexity requirements. Avoid hardcoding sensitive information directly in your Terraform files. Consider using [Terraform Vault Provider](https://registry.terraform.io/providers/hashicorp/vault/latest/docs) for sensitive data management.
- **Customization**: Adjust sizes, regions, and configurations as per your requirements.

## Troubleshooting

If you encounter issues, consider these steps:

1. Review the output of the `terraform apply` command for error messages.
2. Check if your Azure subscription has sufficient resources and permissions to create the specified resources.
3. Consult the [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) for specific resource configuration options.

