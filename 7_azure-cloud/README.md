## README for Azure Infrastructure Setup and Configuration

### 1. Create a Virtual Network (VNet)

**Objective:** Create a VNet for isolating and managing resources within Azure.

#### Steps:
- Navigate to the Azure Portal.
- Go to **Create a Resource** > **Networking** > **Virtual Network**.
- Specify the **Resource Group**, **VNet Name**, **Region**, and **IP Address Space**.
- Add one or more subnets.
- Review and create the VNet.

#### Verification:
- Once the VNet is created, navigate to the **VNet Overview** section to confirm that the configuration details are correct.

---

### 2. Associate Subnets and Attach Network Security Groups (NSGs)

**Objective:** Associate subnets to the VNet and apply NSGs to control inbound and outbound traffic.

#### Steps:
- Navigate to the **Virtual Network** you created.
- Go to the **Subnets** section and add a new subnet if necessary.
- For each subnet, assign an **NSG** by selecting **Network Security Group** in the subnet configuration.
- If the NSG does not exist, create it under **Networking** > **Network Security Groups**.

#### Verification:
- Ensure that the subnets are listed under the VNet and that the NSGs are associated correctly.

---

### 3. Create a Virtual Machine (VM)

**Objective:** Deploy a VM for running applications or services.

#### Steps:
- Go to **Create a Resource** > **Compute** > **Virtual Machine**.
- Choose the **Resource Group**, **VM Name**, **Region**, and **Image** (e.g., Ubuntu Server).
- Configure the **Size**, **Administrator Account**, **Inbound Port Rules**, and **Disks**.
- In the **Networking** tab, choose the **VNet**, **Subnet**, and **Public IP** settings.
- Review and create the VM.

#### Verification:
- Once deployed, connect to the VM using SSH or RDP to verify that it is accessible.

---

### 4. Create a VM and Install WordPress

**Objective:** Deploy a VM and install WordPress on it.

#### Steps:
- Create a new VM following the steps in section 3.
- SSH into the VM and install Apache, MySQL, and PHP:
    ```bash
    sudo apt update
    sudo apt install apache2 mysql-server php php-mysql -y
    ```
- Download and install WordPress:
    ```bash
    wget -c http://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    sudo mv wordpress /var/www/html/
    ```
- Configure the WordPress settings (`wp-config.php`) and set up the MySQL database.

#### Verification:
- Access the WordPress installation via the VM's public IP to confirm it's working.

---

### 5. Create Two VMs: Install a Database on the Second VM

**Objective:** Set up a two-VM configuration, one for the application and the other for the database.

#### Steps:
- Create two VMs following the steps in section 3.
- SSH into the second VM and install a database server (e.g., MySQL):
    ```bash
    sudo apt update
    sudo apt install mysql-server -y
    ```
- Configure the MySQL server to allow remote connections.
- On the first VM, configure the application to connect to the database running on the second VM.

#### Verification:
- Confirm that the first VM can connect to the database on the second VM by testing a sample database query.

---

### 6. Use Cloud-Init for VM Configuration

**Objective:** Automate VM setup using cloud-init scripts during deployment.

#### Steps:
- While creating a VM, go to the **Advanced** tab.
- In the **Cloud-Init** section, paste a cloud-init configuration script, for example:
    ```yaml
    #cloud-config
    package_upgrade: true
    packages:
      - apache2
      - mysql-server
    ```
- Complete the VM creation.

#### Verification:
- SSH into the VM and confirm that the specified packages are installed and configured.

---

### 7. Configure Scale Sets: Scale In and Scale Out

**Objective:** Set up a Virtual Machine Scale Set for automatic scaling.

#### Steps:
- Navigate to **Create a Resource** > **Compute** > **Virtual Machine Scale Sets**.
- Configure the **Resource Group**, **Region**, **Image**, **Instance Size**, and **Instance Count**.
- Set up **Scaling Policies** to define conditions for scale-in and scale-out.
- Review and create the scale set.

#### Verification:
- Simulate load to trigger scaling and observe the scale set's behavior.

---

### 8. Set Up a Load Balancer for the Scale Set

**Objective:** Distribute incoming traffic across multiple instances in a scale set using a load balancer.

#### Steps:
- Navigate to **Create a Resource** > **Networking** > **Load Balancer**.
- Configure the **Frontend IP**, **Backend Pool** (assign the scale set), and **Health Probes**.
- Create **Load Balancer Rules** to define traffic distribution settings.

#### Verification:
- Test the load balancer's functionality by accessing the frontend IP and ensuring traffic is balanced across scale set instances.

---

### 9. Use MySQL Flexible Server

**Objective:** Deploy and configure a MySQL flexible server.

#### Steps:
- Navigate to **Create a Resource** > **Databases** > **Azure Database for MySQL flexible server**.
- Configure the **Resource Group**, **Server Name**, **Region**, **Compute Tier**, and **Storage Size**.
- Configure **Firewall Rules** to allow access from specific IP ranges.

#### Verification:
- Connect to the MySQL server using a MySQL client and test database operations.

---

### 10. Configure Subnet Delegation and Private Endpoint

**Objective:** Enable subnet delegation for specific Azure services and set up private endpoints for secure access.

#### Steps:
- Go to the **VNet** and navigate to **Subnets**.
- Select a subnet and configure **Delegation** for a specific service.
- To create a private endpoint, navigate to **Private Endpoint**, specify the **Resource**, **Subnet**, and **Private DNS Integration**.

#### Verification:
- Test access to the resource using the private endpoint, ensuring public access is blocked.

---

### 11. Azure Functions Using Visual Studio Code

**Objective:** Develop, deploy, and manage Azure Functions using VS Code.

#### Steps:
- Install the **Azure Functions Extension** in VS Code.
- Create a new function project using **Azure Functions: Create New Project**.
- Implement the function and test locally.
- Deploy the function to Azure by selecting **Deploy to Function App**.

#### Verification:
- Test the deployed function in Azure to ensure it executes as expected.

---

### 12. Manage Application Objects and Role-Based Access Control (RBAC)

**Objective:** Configure application objects and assign RBAC roles for access management.

#### Steps:
- Navigate to **Azure Active Directory** > **App Registrations** and create a new application.
- Configure **API Permissions**, **Certificates & Secrets**, and other settings.
- For RBAC, go to **Access Control (IAM)** on a resource and assign roles to users or service principals.

#### Verification:
- Confirm that users or applications have the appropriate access based on assigned roles.

