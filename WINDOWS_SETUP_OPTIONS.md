# RStudio Server on Windows - Setup Options

You're on **Windows**, so the Linux bash script won't work directly. Here are your best options:

---

## ✅ Option 1: Windows Subsystem for Linux (WSL) - **RECOMMENDED**

**Best for:** Native Windows users who want a Linux environment

### Prerequisites
- Windows 10 (build 19041+) or Windows 11
- Administrator access

### Installation Steps

#### Step 1: Enable WSL2

Open PowerShell as Administrator and run:

```powershell
wsl --install
```

This installs:
- WSL2
- Ubuntu Linux (default)
- All necessary components

**Wait for it to complete, then restart your computer.**

#### Step 2: Set Up Ubuntu User

After restart, Ubuntu terminal will open automatically:

```bash
# It will ask you to create a username and password
# Choose a username (e.g., "datauser")
# Enter a password (can be different from Windows password)

# You're now in Linux!
```

#### Step 3: Run the RStudio Setup Script

```bash
# Update Ubuntu packages
sudo apt-get update -y

# Navigate to the setup script and run it
bash /home/user/test/setup_rstudio_server.sh
```

Or if the file isn't accessible, copy the script contents to a new file:

```bash
# Create the script
nano setup_rstudio.sh

# Paste the entire script content from setup_rstudio_server.sh
# Press Ctrl+X, then Y, then Enter to save

# Make it executable
chmod +x setup_rstudio.sh

# Run it
./setup_rstudio.sh
```

#### Step 4: Access RStudio

Once installation completes, from Windows:

1. Open browser
2. Go to: `http://localhost:8787`
3. Login with the Ubuntu username/password you created

**✅ Done!**

---

## ✅ Option 2: Docker (Easiest)

**Best for:** Quick setup with no system changes

### Prerequisites
- Docker Desktop for Windows installed
- Administrator access

### Installation Steps

#### Step 1: Install Docker Desktop

Download and install from: https://www.docker.com/products/docker-desktop

#### Step 2: Run RStudio in Docker

Open PowerShell and run:

```powershell
docker run -d \
  -p 8787:8787 \
  -e PASSWORD=mypassword \
  rocker/rstudio
```

Replace `mypassword` with a password of your choice.

#### Step 3: Access RStudio

1. Open browser
2. Go to: `http://localhost:8787`
3. Login with:
   - **Username:** `rstudio`
   - **Password:** whatever you set above

**✅ Done!**

### To Stop Container

```powershell
docker stop <container-id>
```

Get container ID from:
```powershell
docker ps
```

---

## ✅ Option 3: Native Windows Installation

**Best for:** Running R locally without Linux/Docker

### Install R on Windows

1. Visit: https://cran.r-project.org/bin/windows/base/
2. Click: **Download R 4.x.x for Windows**
3. Run the installer
4. Accept defaults
5. Click: **Finish**

### Install RStudio Desktop (Windows Version)

1. Visit: https://posit.co/download/rstudio-desktop/
2. Under "All Installers", click: **Windows 10/11**
3. Run the installer
4. Accept defaults
5. Click: **Finish**

### Open RStudio

- On Windows, search for "RStudio" in Start menu
- Click to open

**✅ Done!**

**Note:** This gives you the desktop IDE, not RStudio Server (web-based), but it's the easiest for Windows.

---

## 📊 Comparison of Options

| Option | Difficulty | Setup Time | Best For |
|--------|-----------|-----------|----------|
| **WSL2** | Medium | 15-30 min | Linux environment on Windows |
| **Docker** | Easy | 5-10 min | Quick server setup |
| **Native** | Very Easy | 5-10 min | Local desktop use |

---

## 🎯 Quick Decision Guide

**Choose WSL2 if:**
- ✅ You want the Linux experience on Windows
- ✅ You want RStudio Server (web-based)
- ✅ You're comfortable with terminal
- ✅ You want full control

**Choose Docker if:**
- ✅ You want RStudio Server quickly
- ✅ You have Docker Desktop installed
- ✅ You want isolated environment
- ✅ You don't want to modify Windows

**Choose Native if:**
- ✅ You want simplest setup
- ✅ You just need RStudio to work
- ✅ Desktop IDE is fine (not web-based)
- ✅ You want no extra software

---

## 🚀 My Recommendation

**For most Windows users: Docker** ← Easiest!

**For developers: WSL2** ← Most flexible

**For simplicity: Native Windows** ← Quickest

---

## 📋 Detailed Steps by Option

### WSL2 Full Walkthrough

```powershell
# 1. Open PowerShell as Administrator
# 2. Run:
wsl --install

# 3. Restart computer
# 4. Ubuntu terminal opens automatically
# 5. Create username and password
# 6. Run:
sudo apt-get update -y
bash /path/to/setup_rstudio_server.sh

# 7. Open browser to http://localhost:8787
```

### Docker Full Walkthrough

```powershell
# 1. Install Docker Desktop from docker.com
# 2. Open PowerShell
# 3. Run:
docker run -d -p 8787:8787 -e PASSWORD=mypass rocker/rstudio

# 4. Open browser to http://localhost:8787
# 5. Login with username: rstudio, password: mypass
```

### Native Windows Full Walkthrough

```
1. Download R from cran.r-project.org
2. Install R
3. Download RStudio from posit.co
4. Install RStudio
5. Open RStudio from Start menu
6. Start using R!
```

---

## ✅ Which One Should You Choose?

**→ You want to use the bash script?**
Use **WSL2** (option 1)

**→ You want the fastest setup?**
Use **Docker** (option 2)

**→ You want the simplest method?**
Use **Native Windows** (option 3)

---

## 🔗 Download Links

- **WSL2:** Built into Windows (command: `wsl --install`)
- **Docker:** https://www.docker.com/products/docker-desktop
- **R:** https://cran.r-project.org/bin/windows/base/
- **RStudio:** https://posit.co/download/rstudio-desktop/

---

## 💡 Pro Tips

**WSL2:**
- Fast installation
- Full Linux compatibility
- Can run all Linux tools
- Integrates with Windows
- Can access Windows files at `/mnt/c/`

**Docker:**
- Super easy setup
- Reproducible environment
- Can have multiple versions
- Automatic cleanup easy
- No system changes

**Native:**
- Familiar Windows interface
- No learning curve
- Desktop app feel
- Integrates with Windows file explorer
- No additional software needed

---

## 🆘 Troubleshooting

### WSL2
- **Can't enable?** → Your Windows version is too old
- **Bash not found?** → WSL isn't installed yet
- **Port 8787 not accessible?** → Check WSL is running with `wsl --list -v`

### Docker
- **Docker not found?** → Docker Desktop isn't installed
- **Port error?** → Port 8787 already in use, stop other containers

### Native
- **Can't find RStudio?** → Check installation completed
- **R not found in terminal?** → Close and reopen terminal

---

## ✨ Final Recommendation

**If you can choose just one:**

→ **Use Docker** (easiest)
→ **Use WSL2** (if you want Linux)
→ **Use Native** (if you want simplest)

---

**Pick an option above and let me know which one you choose!**

I can provide specific step-by-step instructions for whichever method you select.
