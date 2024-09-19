# WordPress Installation on Ubuntu

## Overview

This project provides scripts to install and configure WordPress on an Ubuntu server with Apache, MySQL, and PHP. It includes scripts for installing prerequisites, setting up the database, configuring Apache, and uninstalling components.

## Contents

- `install_prereq.sh`: Installs required dependencies (Apache, MySQL, PHP).
- `install_wordpress.sh`: Downloads and extracts the latest version of WordPress.
- `configure_apache_for_wordpress.sh`: Configures Apache to serve the WordPress site.
- `db_setup.sh`: Sets up the MySQL database and user for WordPress.
- `wordpress_setup.sh`: Configures WordPress to connect to the database.
- `run.sh`: Executes all setup scripts in order and ensures they are executable.
- `uninstall_wordpress.sh`: Uninstalls WordPress and cleans up associated files and configurations.

## Prerequisites

- Ubuntu server (20.04 or later recommended)
- Root or sudo access

## Installation

1. **Clone the Repository**:

   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Make Scripts Executable**:

   ```bash
   chmod +x *.sh
   ```

3. **Run the Setup**:

   Execute the `run.sh` script to install and configure WordPress:

   ```bash
   ./run.sh
   ```

4. **Access WordPress**:

   Open a web browser and navigate to `http://<your-server-ip>/` to complete the WordPress setup through the web interface.

## Uninstallation

To remove WordPress and its components, run:

```bash
./uninstall_wordpress.sh
```

## Notes

- Make sure to replace `<your-password>` with a secure password in the relevant scripts.
- Adjust configurations in the scripts as needed to fit your environment.

## Troubleshooting

- If you encounter issues, check the Apache logs located in `/var/log/apache2/error.log`.
- Ensure that the MySQL service is running if you have issues connecting to the database.



This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to customize any sections to better fit your project's specific requirements!
