# RStudio Server Installation Walkthrough

Complete step-by-step guide to get RStudio Server up and running on your system.

---

## 📋 Pre-Installation Checklist

Before you start, verify you have:

- [ ] Linux system (Ubuntu/Debian-based recommended)
- [ ] Internet connection (for downloading packages)
- [ ] Terminal/command line access
- [ ] Root/sudo privileges
- [ ] ~30 minutes of time (10-20 minutes for installation + 10 minutes for configuration)

---

## 🚀 STEP 1: Verify Files Are Ready

First, check that all setup files are in place:

```bash
ls -lh /home/user/test/setup_rstudio_server.sh
```

**Expected output:**
```
-rwxr-xr-x 1 root root 8.7K Feb 20 16:50 /home/user/test/setup_rstudio_server.sh
```

The `x` permission means the file is executable (ready to run).

**If you don't see this file:**
```bash
cd /home/user/test
bash setup_rstudio_server.sh  # This will create it with proper permissions
```

---

## ⚙️ STEP 2: Run the Installation Script

### Option A: Run Directly (Recommended)

Navigate to the test directory and run the script:

```bash
cd /home/user/test
bash setup_rstudio_server.sh
```

### Option B: Run from Anywhere

If you're in a different directory:

```bash
bash /home/user/test/setup_rstudio_server.sh
```

### What You'll See

The script provides clear feedback with progress indicators:

```
╔════════════════════════════════════════════════════════════════════════════╗
║         R Development Environment Setup with RStudio Server                ║
╚════════════════════════════════════════════════════════════════════════════╝

[1/6] Updating system packages...
✓ System packages updated

[2/6] Installing R dependencies...
✓ Dependencies installed

[3/6] Installing R...
✓ R installed: R version 4.3.2 (2023-10-31)

[4/6] Installing RStudio Server...
✓ RStudio Server installed successfully

[5/6] Configuring RStudio Server...
✓ RStudio Server is running

[6/6] Installing common R packages...
✓ Common R packages installed

═════════════════════════════════════════════════════════════════════════════════
Setup Complete! 🎉
═════════════════════════════════════════════════════════════════════════════════
```

---

## ⏱️ STEP 3: Wait for Installation to Complete

**Total time: 10-20 minutes**

Depending on internet speed:
- Fast connection (>50 Mbps): ~10 minutes
- Normal connection (10-50 Mbps): ~15 minutes
- Slow connection (<10 Mbps): ~20 minutes

**During installation:**
- R packages will download and install
- This may take a while - **this is normal, be patient!**
- Don't close the terminal window
- Don't interrupt the process (Ctrl+C)

---

## ✅ STEP 4: Verify Installation Success

Once the script completes, you should see:

```
R Version:
    R version 4.3.2 (2023-10-31) -- "Eye Holes"

Installed Packages:
    155 packages installed

Ready to go! Happy coding! 🚀
```

### Check Service Status

Verify RStudio Server is running:

```bash
sudo systemctl status rstudio-server
```

**Expected output:**
```
● rstudio-server.service - RStudio Server
   Loaded: loaded (/etc/systemd/system/rstudio-server.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2024-02-20 16:50:00 UTC; 2min ago
   Process: 12345 ExecStart=/usr/lib/rstudio-server/bin/rstudio-server verify-installation (code=exited, status=0/SUCCESS)
```

**Key things to look for:**
- `Active: active (running)` ✅ Good!
- `enabled` in the Loaded line ✅ It will auto-start

### Check R Installation

Verify R is working:

```bash
R --version
```

**Expected output:**
```
R version 4.3.2 (2023-10-31) -- "Eye Holes"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu
...
```

### Check Port is Listening

Verify RStudio Server is listening on port 8787:

```bash
sudo netstat -tlnp | grep 8787
```

**Expected output:**
```
tcp        0      0 0.0.0.0:8787            0.0.0.0:*               LISTEN      12345/rsession
```

---

## 🌐 STEP 5: Access RStudio Server

### From the Same Computer

**Option 1: Using Firefox/Chrome/Safari**

1. Open your web browser
2. In the address bar, type:
   ```
   http://localhost:8787
   ```
3. Press Enter
4. You should see the RStudio login screen

**Option 2: Using the Command Line**

If you want to open it automatically from terminal:
```bash
# On Linux with Firefox
firefox http://localhost:8787 &

# On Linux with Chrome
google-chrome http://localhost:8787 &

# On macOS with Safari
open http://localhost:8787

# On macOS with Chrome
open -a "Google Chrome" http://localhost:8787
```

### From Another Computer (Same Network)

1. Find your computer's IP address:
   ```bash
   hostname -I
   ```

   **Example output:**
   ```
   192.168.1.100
   ```

2. On the other computer, open browser and visit:
   ```
   http://192.168.1.100:8787
   ```

### From the Internet (Secure SSH Tunnel)

For secure remote access, use SSH tunneling:

**On your local computer:**
```bash
ssh -L 8787:localhost:8787 username@your-server.com
```

Then open browser to: `http://localhost:8787`

---

## 🔑 STEP 6: Login to RStudio Server

### Login Credentials

- **Username:** Your Linux system username
- **Password:** Your Linux system password

**Example:**
- If your user is `john` and password is `mypassword123`
- Enter those credentials exactly

### First Login

1. RStudio Server login page appears
2. Enter your username
3. Enter your password
4. Click "Sign In"
5. Wait for RStudio to load (10-30 seconds)

### RStudio Interface Appears

Once logged in, you should see:

```
┌─────────────────────────────────────────────────────────────┐
│  File  Edit  View  Tools  Help                  |  ≡        │
├──────────────────────────┬──────────────────────────────────┤
│  Console                 │  Environment | History | Packages│
│                          │                                  │
│  > _                     │  Global Environment              │
│                          │                                  │
├──────────────────────────┼──────────────────────────────────┤
│  Files | Plots | Packages│ R Markdown | Viewer              │
│                          │                                  │
│ (default location)       │                                  │
└──────────────────────────┴──────────────────────────────────┘
```

**Congratulations! ✅ RStudio Server is ready to use!**

---

## 🧪 STEP 7: Verify Everything Works

Test that R is working properly inside RStudio:

### Simple Test

1. In the Console (bottom-left), type:
   ```r
   2 + 2
   ```

2. Press Enter

3. You should see:
   ```
   > 2 + 2
   [1] 4
   ```

### Install a Package Test

```r
install.packages("ggplot2", type = "binary")
```

This tests that package installation works. After ~30 seconds, you should see:
```
> install.packages("ggplot2", type = "binary")
trying URL 'http://cran.r-project.org/bin/linux/ubuntu/jammy/ggplot2_3.4.0_all.deb'
...
**DONE**
```

### Create Your First Plot

```r
library(ggplot2)

# Create sample data
data <- data.frame(x = 1:10, y = rnorm(10))

# Create plot
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  geom_line() +
  theme_minimal() +
  labs(title = "My First RStudio Plot!")
```

You should see a plot appear in the Plots tab (bottom-right).

---

## 🆘 STEP 8: Troubleshooting

### Problem: Can't access http://localhost:8787

**Solution 1: Check if service is running**
```bash
sudo systemctl status rstudio-server
```

If not running:
```bash
sudo systemctl start rstudio-server
sudo systemctl status rstudio-server
```

**Solution 2: Check if port is being used**
```bash
sudo lsof -i :8787
```

If something else is using port 8787, kill it:
```bash
sudo kill -9 <PID>
```

Then restart RStudio:
```bash
sudo systemctl restart rstudio-server
```

**Solution 3: Check firewall**
```bash
sudo ufw status
```

If firewall is enabled and blocking port 8787:
```bash
sudo ufw allow 8787/tcp
```

### Problem: Login fails with "Invalid username or password"

**Solution 1: Verify username**
```bash
whoami
```

This shows your current username - use this exact username.

**Solution 2: Reset password**
```bash
sudo passwd yourusername
```

Then try logging in again.

**Solution 3: Create new user**
```bash
sudo useradd -m newusername
sudo passwd newusername
```

Then login with the new username.

### Problem: R takes forever to load

**Solution: Clear cache and restart**
```bash
sudo systemctl restart rstudio-server

# Wait 10 seconds, then try accessing again
sleep 10
```

### Problem: Can't install packages

**Solution 1: Update package index**
```r
update.packages(ask = FALSE)
```

**Solution 2: Install with dependencies**
```r
install.packages("package_name", dependencies = TRUE)
```

**Solution 3: Try different CRAN mirror**
```r
options(repos = "http://mirror.example.com/CRAN")
install.packages("package_name")
```

---

## 📊 STEP 9: Your First R Project

Now that everything works, create your first project:

### Create New Project

1. In RStudio, click: **File** → **New Project**
2. Choose: **New Directory**
3. Choose: **Empty Project**
4. Enter project name: `my_first_project`
5. Choose location (or use default)
6. Click **Create Project**

### Create R Script

1. Click: **File** → **New File** → **R Script**
2. Paste this code:

```r
# My First R Analysis
# ==================

# Load libraries
library(ggplot2)
library(dplyr)

# Create sample dataset
df <- data.frame(
  month = month.abb[1:12],
  sales = c(100, 110, 120, 130, 140, 150, 155, 160, 150, 140, 130, 120),
  profit = c(20, 25, 30, 35, 40, 45, 50, 55, 50, 45, 40, 35)
)

# Display data
print(df)

# Summary statistics
summary(df)

# Create visualization
ggplot(df, aes(x = month, y = sales, fill = profit)) +
  geom_col() +
  theme_minimal() +
  labs(
    title = "Monthly Sales and Profit",
    x = "Month",
    y = "Sales ($)",
    fill = "Profit ($)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

3. Click the **Save** button (or Ctrl+S)
4. Select all code (Ctrl+A)
5. Click **Run** or press Ctrl+Enter
6. Results appear in Console and Plot tabs

---

## 📚 STEP 10: Next Steps & Resources

### Built-in Help

In RStudio Console:
```r
# Help on specific function
?ggplot
help("dplyr")

# Search documentation
help.search("linear regression")

# List vignettes (tutorials)
vignette()
vignette("ggplot2-specs")
```

### Online Resources

- **R Basics**: https://www.r-project.org/
- **Tidyverse** (data science): https://www.tidyverse.org/
- **ggplot2** (visualization): https://ggplot2.tidyverse.org/
- **RMarkdown** (reports): https://rmarkdown.rstudio.com/
- **Shiny** (web apps): https://shiny.rstudio.com/
- **Stack Overflow**: Tag questions with `[r]`

### RStudio Tips

| Shortcut | Action |
|----------|--------|
| Ctrl + Enter | Run current line |
| Ctrl + Shift + Enter | Run entire script |
| Ctrl + / | Toggle comment |
| Tab | Auto-complete |
| Alt + - | Insert <- operator |
| Ctrl + Alt + R | Run entire script |

---

## ✨ Success! You're Done!

You now have:

✅ R installed and working
✅ RStudio Server accessible
✅ 20+ packages ready to use
✅ First project created
✅ Basic knowledge of RStudio

### Quick Reference Command

Whenever you need to restart RStudio Server:
```bash
sudo systemctl restart rstudio-server
```

### Access It Anytime

To use RStudio Server in the future, just visit:
```
http://localhost:8787
```

And login with your system credentials.

---

## 🎓 Common Workflows

### Data Analysis Workflow

```r
# 1. Load data
data <- read.csv("mydata.csv")

# 2. Explore
head(data)
summary(data)
str(data)

# 3. Clean
library(dplyr)
data <- data %>%
  filter(!is.na(value)) %>%
  mutate(category = tolower(category))

# 4. Analyze
model <- lm(outcome ~ predictor, data = data)
summary(model)

# 5. Visualize
library(ggplot2)
ggplot(data, aes(x = predictor, y = outcome)) +
  geom_point() +
  geom_smooth(method = "lm")
```

### Report Generation

```r
# Create RMarkdown document
# File → New File → R Markdown
# Then include code chunks and text
# Click "Knit" to generate PDF/HTML/Word report
```

### Interactive App Creation

```r
# Install Shiny
install.packages("shiny")

# File → New File → Shiny Web App
# Build interactive data exploration apps
```

---

## 🚨 Emergency Commands

If things go wrong:

```bash
# Stop RStudio Server
sudo systemctl stop rstudio-server

# Check what's wrong
sudo systemctl status rstudio-server

# View logs
sudo journalctl -u rstudio-server -n 50

# Restart everything
sudo systemctl restart rstudio-server

# Force restart (nuclear option)
sudo killall rsession
sudo systemctl restart rstudio-server
```

---

**You're all set! Happy data science! 🎉**
