# RStudio Server Development Environment Setup

## Overview

This guide sets up a complete R development environment with **RStudio Server**, a web-based IDE that allows you to work with R from any browser. This is ideal for:

- Remote development without installing software locally
- Server-based analytics and data science work
- Collaborative projects (multiple users on same server)
- Containerized/cloud deployments
- GUI-based R development with powerful features

## What Gets Installed

### Core Components
- **R (latest version)** - Statistical computing language
- **RStudio Server** - Browser-based IDE for R
- **Development tools** - Build utilities, compilers, libraries

### Pre-installed R Packages

#### Data Science & Analysis
- `tidyverse` - Collection of data science packages
- `ggplot2` - Advanced data visualization
- `dplyr` - Data manipulation
- `tidyr` - Data tidying
- `readr` - Data import
- `data.table` - Fast data manipulation

#### Web & Interactive Apps
- `shiny` - Interactive web applications
- `ggvis` - Interactive graphics
- `markdown` - Markdown support
- `rmarkdown` - Dynamic document generation

#### Development
- `devtools` - Package development tools
- `testthat` - Unit testing framework
- `knitr` - Dynamic report generation
- `xtable` - LaTeX/HTML table generation

#### Additional
- `magrittr` - Pipe operators (`%>%`)
- `lubridate` - Date/time handling
- `stringr` - String manipulation
- `lattice` - Classic graphics
- `Matrix` - Sparse matrices

## Installation Instructions

### Quick Install (Automated)

```bash
bash setup_rstudio_server.sh
```

This script will:
1. Update system packages
2. Install R dependencies
3. Install R from CRAN
4. Download and install RStudio Server
5. Configure RStudio Server as a system service
6. Install common R packages

**Estimated time:** 10-20 minutes (depending on internet speed)

### Manual Installation Steps

If you prefer to install manually:

#### 1. Update System
```bash
sudo apt-get update
sudo apt-get upgrade -y
```

#### 2. Install Dependencies
```bash
sudo apt-get install -y \
  build-essential \
  gfortran \
  libreadline-dev \
  libx11-dev \
  libxt-dev \
  libpng-dev \
  libjpeg-dev \
  libcairo2-dev \
  libssl-dev \
  libcurl4-openssl-dev \
  libxml2-dev
```

#### 3. Add R Repository and Install R
```bash
# Add CRAN repository key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# Add R CRAN repository
echo "deb http://cran.r-project.org/bin/linux/ubuntu focal-cran40/" | sudo tee -a /etc/apt/sources.list

# Install R
sudo apt-get update
sudo apt-get install -y r-base r-base-dev
```

#### 4. Install RStudio Server
```bash
# Download RStudio Server
wget https://rstudio.org/download/latest/stable/server/bionic/rstudio-server-latest-amd64.deb

# Install
sudo gdebi rstudio-server-latest-amd64.deb

# Clean up
rm rstudio-server-latest-amd64.deb
```

#### 5. Start RStudio Server
```bash
sudo systemctl start rstudio-server
sudo systemctl enable rstudio-server  # Start on boot
```

#### 6. Install R Packages
```bash
R --vanilla << 'EOF'
packages <- c("tidyverse", "ggplot2", "shiny", "rmarkdown", "devtools")
install.packages(packages)
EOF
```

## Accessing RStudio Server

### Local Access
1. Open your web browser
2. Navigate to: **http://localhost:8787**
3. Login with your system credentials
   - Username: Your Linux username
   - Password: Your Linux password

### Remote Access
1. Replace `localhost` with your server's IP or hostname
2. Example: **http://192.168.1.100:8787**
3. Same login credentials

### Through SSH Tunnel (Secure Remote Access)
```bash
# Create SSH tunnel from your local machine
ssh -L 8787:localhost:8787 user@server.com

# Then access in browser: http://localhost:8787
```

## Service Management

### Check Service Status
```bash
sudo systemctl status rstudio-server
```

### Control RStudio Server
```bash
# Start the service
sudo systemctl start rstudio-server

# Stop the service
sudo systemctl stop rstudio-server

# Restart the service
sudo systemctl restart rstudio-server

# View logs
sudo systemctl journal rstudio-server -n 50
```

## Firewall Configuration

### Allow Remote Access (UFW)
```bash
# Allow RStudio Server port
sudo ufw allow 8787/tcp

# Allow SSH for secure tunneling
sudo ufw allow 22/tcp
```

### Check Firewall Status
```bash
sudo ufw status
```

## Configuration

### RStudio Server Configuration File
Location: `/etc/rstudio/rserver.conf`

**Common settings:**
```conf
# Change port (default is 8787)
www-port=8787

# Set session timeout (minutes)
session-timeout-minutes=30

# Enable/disable SSL
www-use-ssl=1
www-ssl-cert-file=/path/to/cert
www-ssl-key-file=/path/to/key
```

After editing, restart the service:
```bash
sudo systemctl restart rstudio-server
```

### Add More R Libraries (System-wide)
```bash
# Install in system R library
sudo R --vanilla << 'EOF'
install.packages(c("package1", "package2"))
EOF
```

## Troubleshooting

### Cannot Connect to RStudio Server
```bash
# Check if service is running
sudo systemctl status rstudio-server

# Start service if stopped
sudo systemctl start rstudio-server

# Check listening ports
sudo netstat -tlnp | grep 8787
```

### Port 8787 Already in Use
```bash
# Find process using port 8787
sudo lsof -i :8787

# Kill the process (if needed)
sudo kill -9 <PID>

# Or change RStudio Server port in /etc/rstudio/rserver.conf
```

### Authentication Issues
```bash
# RStudio Server uses system PAM for authentication
# Ensure your user account exists:
sudo useradd -m newuser

# Set password if needed:
sudo passwd newuser
```

### Package Installation Fails
```bash
# Update package list
update.packages()

# Check R version compatibility
R --version

# Install with dependencies
install.packages("package_name", dependencies = TRUE)
```

## Working with Projects

### Create New R Project in RStudio
1. File → New Project → New Directory → Empty Project
2. Name and location
3. Create project
4. All files stored in project directory

### Version Control Integration
RStudio Server has built-in Git/GitHub support:
1. Tools → Version Control → Project Setup
2. Create Git repository
3. Commit changes through RStudio interface

## Tips & Best Practices

### Development Workflow
1. **Organize** projects in separate directories
2. **Use R projects** for better organization
3. **Create R scripts** for reusable code
4. **Use RMarkdown** for reports and documentation
5. **Test** code with `testthat` package

### Performance Optimization
- Increase available RAM for large datasets
- Use `data.table` for faster operations
- Parallelize computations with `parallel` package
- Monitor system resources in RStudio

### Security Best Practices
- **Use strong passwords** for system accounts
- **Enable SSH tunneling** for remote access
- **Configure firewall** to restrict port access
- **Use HTTPS** (SSL/TLS) for sensitive work
- **Regular backups** of R projects and data

### R Package Management
```r
# List installed packages
installed.packages()

# Update packages
update.packages()

# Remove packages
remove.packages("package_name")

# Install from GitHub
devtools::install_github("username/repo")
```

## Advanced Topics

### Installing from Source
```r
# Install from GitHub
devtools::install_github("hadley/ggplot2")

# Install specific version
install.packages("ggplot2", type = "source")
```

### Custom R Configuration
Edit `~/.Rprofile` to customize R startup:
```r
# Example: Set default repository
options(repos = "http://cran.r-project.org")

# Set width of output
options(width = 100)

# Suppress warnings
options(warn = -1)
```

### Container Deployment
RStudio Server works well with Docker. Example Dockerfile:
```dockerfile
FROM ubuntu:focal

# Install dependencies and RStudio Server (as above)
RUN apt-get update && apt-get install -y r-base ...
RUN wget ... && gdebi rstudio-server ...

EXPOSE 8787
CMD ["/usr/lib/rstudio-server/bin/rstudio-server", "run"]
```

## Resources

- **Official RStudio Server Docs**: https://docs.rstudio.com/connect/user/rstudio-server/
- **R CRAN Repository**: https://cran.r-project.org/
- **Tidyverse**: https://www.tidyverse.org/
- **RMarkdown**: https://rmarkdown.rstudio.com/
- **Shiny**: https://shiny.rstudio.com/

## Support & Troubleshooting

For detailed help:
```bash
# View RStudio Server logs
sudo tail -f /var/log/rstudio-server.log

# R help in RStudio
?function_name
help(package = "package_name")

# Get R version info
R --version
sessionInfo()
```

---

**Setup completed successfully!** Start using RStudio Server at http://localhost:8787
