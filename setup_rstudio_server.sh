#!/bin/bash

# ============================================================================
# RStudio Server Development Environment Setup
# ============================================================================
# This script installs R and RStudio Server on a Linux system
# Run with: bash setup_rstudio_server.sh

set -e  # Exit on error

echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║         R Development Environment Setup with RStudio Server                ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================================================
# STEP 1: Update system packages
# ============================================================================
echo -e "${BLUE}[1/6]${NC} Updating system packages..."
sudo apt-get update -qq
sudo apt-get upgrade -y -qq > /dev/null 2>&1
echo -e "${GREEN}✓${NC} System packages updated"
echo ""

# ============================================================================
# STEP 2: Install dependencies for R
# ============================================================================
echo -e "${BLUE}[2/6]${NC} Installing R dependencies..."
sudo apt-get install -y -qq \
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
  libxml2-dev \
  > /dev/null 2>&1
echo -e "${GREEN}✓${NC} Dependencies installed"
echo ""

# ============================================================================
# STEP 3: Add R repository and install R
# ============================================================================
echo -e "${BLUE}[3/6]${NC} Installing R..."

# Add the CRAN repository key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 > /dev/null 2>&1 || true

# Add R repository (using Ubuntu focal as fallback if needed)
echo "deb http://cran.r-project.org/bin/linux/ubuntu focal-cran40/" | sudo tee -a /etc/apt/sources.list > /dev/null 2>&1 || true

# Update and install R
sudo apt-get update -qq > /dev/null 2>&1 || true
sudo apt-get install -y -qq r-base r-base-dev > /dev/null 2>&1

# Verify R installation
R_VERSION=$(R --version | head -1)
echo -e "${GREEN}✓${NC} R installed: $R_VERSION"
echo ""

# ============================================================================
# STEP 4: Download and install RStudio Server
# ============================================================================
echo -e "${BLUE}[4/6]${NC} Installing RStudio Server..."

# Get the latest RStudio Server version
RSTUDIO_VERSION="2024.12.0-369"
RSTUDIO_URL="https://download2.rstudio.org/server/focal/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb"

# Alternative URL if primary fails
RSTUDIO_ALT_URL="https://rstudio.org/download/latest/stable/server/bionic/rstudio-server-latest-amd64.deb"

echo "  Downloading RStudio Server..."
if wget -q "$RSTUDIO_URL" -O /tmp/rstudio-server.deb 2>/dev/null; then
  echo "  Installing RStudio Server..."
  sudo gdebi --non-interactive /tmp/rstudio-server.deb > /dev/null 2>&1
elif wget -q "$RSTUDIO_ALT_URL" -O /tmp/rstudio-server.deb 2>/dev/null; then
  echo "  Installing RStudio Server (latest)..."
  sudo gdebi --non-interactive /tmp/rstudio-server.deb > /dev/null 2>&1
else
  echo -e "${YELLOW}⚠${NC} Failed to download RStudio Server from standard URLs"
  echo "  Attempting to install from system repository..."
  sudo apt-get install -y -qq rstudio-server 2>/dev/null || {
    echo -e "${YELLOW}⚠${NC} RStudio Server not available in system repositories"
    echo "  You can install it manually from: https://posit.co/download/rstudio-server/"
  }
fi

# Clean up
rm -f /tmp/rstudio-server.deb

# Verify RStudio Server installation
if command -v rstudio-server &> /dev/null; then
  echo -e "${GREEN}✓${NC} RStudio Server installed successfully"
else
  echo -e "${YELLOW}⚠${NC} RStudio Server installation may have partial success"
fi
echo ""

# ============================================================================
# STEP 5: Start RStudio Server and configure
# ============================================================================
echo -e "${BLUE}[5/6]${NC} Configuring RStudio Server..."

# Start RStudio Server
sudo systemctl start rstudio-server || true

# Enable RStudio Server to start on boot
sudo systemctl enable rstudio-server > /dev/null 2>&1 || true

# Verify service is running
if sudo systemctl is-active --quiet rstudio-server; then
  echo -e "${GREEN}✓${NC} RStudio Server is running"
else
  echo -e "${YELLOW}⚠${NC} RStudio Server status: check with 'sudo systemctl status rstudio-server'"
fi
echo ""

# ============================================================================
# STEP 6: Install R packages
# ============================================================================
echo -e "${BLUE}[6/6]${NC} Installing common R packages..."

# Install commonly used packages
R_PACKAGES="
tidyverse
ggplot2
dplyr
tidyr
readr
ggvis
shiny
markdown
rmarkdown
knitr
xtable
devtools
testthat
"

echo "  Installing packages (this may take a few minutes)..."
sudo Rscript << 'RSCRIPT' > /dev/null 2>&1
packages <- c(
  "tidyverse", "ggplot2", "dplyr", "tidyr", "readr",
  "ggvis", "shiny", "markdown", "rmarkdown", "knitr",
  "xtable", "devtools", "testthat", "lattice", "Matrix",
  "data.table", "magrittr", "lubridate", "stringr"
)

missing_packages <- packages[!(packages %in% rownames(installed.packages()))]

if(length(missing_packages) > 0) {
  install.packages(missing_packages, quiet = TRUE, repos = "http://cran.r-project.org")
}

cat("Successfully installed R packages\n")
RSCRIPT

echo -e "${GREEN}✓${NC} Common R packages installed"
echo ""

# ============================================================================
# SUMMARY AND CONFIGURATION
# ============================================================================
echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║                    Setup Complete! 🎉                                      ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo ""

echo -e "${GREEN}✓ Installation Summary:${NC}"
echo "  • R (latest version)"
echo "  • RStudio Server (web-based IDE)"
echo "  • Essential R packages (tidyverse, ggplot2, shiny, etc.)"
echo ""

echo -e "${BLUE}Quick Start Guide:${NC}"
echo "  1. Open your browser"
echo "  2. Navigate to: http://localhost:8787"
echo "  3. Login with your system username and password"
echo "  4. Start developing in R!"
echo ""

echo -e "${YELLOW}Important Information:${NC}"
echo "  • RStudio Server runs on port 8787"
echo "  • Default access: http://localhost:8787"
echo "  • Service management:"
echo "    - Start:   sudo systemctl start rstudio-server"
echo "    - Stop:    sudo systemctl stop rstudio-server"
echo "    - Restart: sudo systemctl restart rstudio-server"
echo "    - Status:  sudo systemctl status rstudio-server"
echo ""

echo -e "${BLUE}Access from Remote Machines:${NC}"
echo "  If accessing from another computer, replace 'localhost' with:"
echo "  • Your machine's IP address"
echo "  • Hostname (if on the same network)"
echo "  Example: http://192.168.1.100:8787"
echo ""

echo -e "${BLUE}Installing Additional Packages:${NC}"
echo "  In RStudio Console, use:"
echo "  install.packages('package_name')"
echo ""

echo -e "${YELLOW}Firewall Configuration (if needed):${NC}"
echo "  To allow remote access, open port 8787:"
echo "  sudo ufw allow 8787/tcp"
echo ""

# ============================================================================
# Final Verification
# ============================================================================
echo -e "${BLUE}Verifying Installation:${NC}"
echo "  R Version:"
R --version | head -1 | sed 's/^/    /'
echo ""

echo "  Installed Packages:"
R --quiet --vanilla -e "cat(paste('   ', length(rownames(installed.packages())), 'packages installed\n'))"
echo ""

echo -e "${GREEN}Ready to go! Happy coding! 🚀${NC}"
