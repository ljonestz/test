# 🚀 RStudio Server Setup - START HERE

**You have everything you need to get a professional R development environment running!**

---

## ⏱️ Time Breakdown

| Step | Action | Time |
|------|--------|------|
| 1 | Run setup script | < 1 minute |
| 2 | Wait for installation | 10-20 minutes |
| 3 | Verify it worked | 1 minute |
| 4 | Open in browser | < 1 minute |
| 5 | Login and test | 2-3 minutes |
| **Total** | | **15-30 minutes** |

---

## 🎯 The Complete Process (6 Steps)

### **STEP 1: Open Terminal**

Open your terminal/command line application.

```bash
# You should see a prompt that looks like:
user@computer:~$
```

---

### **STEP 2: Run the Installation Script**

Copy and paste this command into your terminal:

```bash
bash /home/user/test/setup_rstudio_server.sh
```

Press **Enter**.

---

### **STEP 3: Watch the Progress**

The script will show progress like this:

```
╔════════════════════════════════════════════════════════════════════════════╗
║         R Development Environment Setup with RStudio Server                ║
╚════════════════════════════════════════════════════════════════════════════╝

[1/6] Updating system packages...
✓ System packages updated

[2/6] Installing R dependencies...
✓ Dependencies installed

[3/6] Installing R...
✓ R installed: R version 4.3.2

[4/6] Installing RStudio Server...
✓ RStudio Server installed successfully

[5/6] Configuring RStudio Server...
✓ RStudio Server is running

[6/6] Installing common R packages...
(Installing packages... this takes a few minutes)
```

**What to do:**
- ✅ Just wait - don't close the terminal
- ✅ It's normal if it takes 10-20 minutes
- ✅ You'll see ✓ checkmarks as each step completes

---

### **STEP 4: Wait for Completion**

Once complete, you'll see:

```
═════════════════════════════════════════════════════════════════════════════════
Setup Complete! 🎉
═════════════════════════════════════════════════════════════════════════════════

R Version:
    R version 4.3.2 (2023-10-31) -- "Eye Holes"

Installed Packages:
    155 packages installed

Ready to go! Happy coding! 🚀
```

The script is done. You can now close this terminal.

---

### **STEP 5: Verify Installation**

Open a new terminal and run:

```bash
sudo systemctl status rstudio-server
```

You should see:

```
● rstudio-server.service - RStudio Server
   Loaded: loaded
   Active: active (running)
```

✅ **"active (running)"** = Good! It's working!

---

### **STEP 6: Open RStudio in Your Browser**

Click this link or type in your browser address bar:

```
http://localhost:8787
```

**You should see the RStudio login screen:**

```
╔─────────────────────────────────╗
│   RStudio Server                │
├─────────────────────────────────┤
│  Username:  ________________    │
│  Password:  ________________    │
│                                 │
│         [Sign In]               │
└─────────────────────────────────┘
```

---

## 🔑 Login

**Username:** Your Linux username

To find it:
```bash
whoami
```

**Password:** Your Linux password (the one you use to login to your computer)

**Click "Sign In"**

---

## ✨ You're In!

After logging in, you should see the RStudio interface:

```
┌──────────────────────────────────────────────────────────────────┐
│  File  Edit  View  Tools  Help                    Workspace |    │
├──────────────────────────┬──────────────────────────────────────┤
│                          │  Environment | History | Packages    │
│                          │                                      │
│  Console                 │  Global Environment                 │
│  > _                     │  (empty)                            │
│                          │                                      │
├──────────────────────────┼──────────────────────────────────────┤
│  Files | Plots | Packages│  R Markdown | Viewer                │
│                          │                                      │
│ (Files in current dir)   │                                      │
└──────────────────────────┴──────────────────────────────────────┘
```

---

## 🧪 Quick Test

Type this in the **Console** (bottom-left):

```r
2 + 2
```

Press **Enter**

You should see:
```
> 2 + 2
[1] 4
```

✅ **It works!**

---

## 📝 Next Steps

### Create Your First Project

1. Click: **File** → **New Project**
2. Choose: **New Directory**
3. Name it: `my_first_project`
4. Click: **Create Project**

### Create a Script

1. Click: **File** → **New File** → **R Script**
2. Type some code:
   ```r
   # My first R script
   library(ggplot2)

   x <- 1:10
   y <- rnorm(10)

   ggplot(data.frame(x, y), aes(x, y)) +
     geom_point() +
     theme_minimal()
   ```
3. Click **Run** (or press **Ctrl + Enter**)
4. You'll see a plot in the Plots tab!

---

## 📚 You Now Have

✅ **R** - Statistical computing language
✅ **RStudio Server** - Professional IDE (web-based)
✅ **20+ Packages** pre-installed:
- **tidyverse** - Data science toolkit
- **ggplot2** - Advanced visualization
- **shiny** - Interactive web apps
- **rmarkdown** - Reports and documents
- **devtools** - Package development
- And more!

---

## 🎓 Learning Resources

### In RStudio Console

```r
# Get help
help()
help("ggplot")
?tidyverse

# List packages
library()

# Install more packages
install.packages("package_name")
```

### Online

- **Tidyverse** (Data Science): https://www.tidyverse.org/
- **ggplot2** (Visualization): https://ggplot2.tidyverse.org/
- **RMarkdown** (Reports): https://rmarkdown.rstudio.com/
- **Shiny** (Web Apps): https://shiny.rstudio.com/

---

## ⌨️ Useful Keyboard Shortcuts

| Shortcut | What it does |
|----------|--------------|
| Ctrl + Enter | Run current line |
| Ctrl + Shift + Enter | Run entire script |
| Ctrl + / | Comment/uncomment |
| Tab | Auto-complete |
| Alt + - | Insert `<-` operator |
| Ctrl + L | Clear console |

---

## 🆘 Troubleshooting

### "Can't connect to http://localhost:8787"

**Solution:**
```bash
sudo systemctl restart rstudio-server
sleep 10
# Then try again in browser
```

### "Login failed"

Check your username:
```bash
whoami
```

Make sure you're using the exact username and correct password.

### "Port 8787 already in use"

```bash
sudo lsof -i :8787
sudo kill -9 <PID>
sudo systemctl restart rstudio-server
```

### "R takes forever to load"

```bash
# Restart the service
sudo systemctl restart rstudio-server

# Clear browser cache (Ctrl + Shift + Delete)
# Then refresh the page
```

**For more troubleshooting, see:** `INSTALLATION_WALKTHROUGH.md`

---

## 📋 Files You Have

1. **setup_rstudio_server.sh**
   - The automated installer (already ran this)

2. **START_HERE.md** (this file)
   - Quick start guide

3. **INSTALLATION_QUICK_REFERENCE.txt**
   - One-page reference card

4. **INSTALLATION_WALKTHROUGH.md**
   - Detailed 10-step guide

5. **RSTUDIO_SERVER_SETUP.md**
   - Comprehensive documentation

---

## 🚀 Access Anytime

Whenever you want to use RStudio:

1. Open browser
2. Go to: **http://localhost:8787**
3. Login with your system credentials
4. Start coding!

### Remote Access (from another computer)

```
http://<your-ip>:8787
```

Example: `http://192.168.1.100:8787`

To find your IP:
```bash
hostname -I
```

---

## 💡 Pro Tips

**Tip 1: Create Projects for Organization**
- Each project = separate working directory
- File → New Project → New Directory
- Keep related files together

**Tip 2: Use RMarkdown for Reports**
- File → New File → R Markdown
- Mix code + text + visualizations
- Generate PDF, Word, or HTML reports

**Tip 3: Install More Packages Anytime**
```r
install.packages("package_name")
```

**Tip 4: Get Help on Anything**
```r
?function_name
help(package)
```

---

## ✅ Checklist: You're Ready If...

- [ ] Ran the setup script
- [ ] Saw ✓ checkmarks for all 6 steps
- [ ] Can access http://localhost:8787
- [ ] Can login with your username/password
- [ ] Can see the RStudio interface
- [ ] Can run `2 + 2` and get `[1] 4`
- [ ] Can see the Plots tab

**If all checked, you're ready to start data science! 🎉**

---

## 🎯 Quick Command Reference

```bash
# Start RStudio Server
sudo systemctl start rstudio-server

# Stop RStudio Server
sudo systemctl stop rstudio-server

# Restart RStudio Server
sudo systemctl restart rstudio-server

# Check status
sudo systemctl status rstudio-server

# View logs
sudo journalctl -u rstudio-server -n 50

# Check R version
R --version

# Check port 8787
sudo netstat -tlnp | grep 8787
```

---

## 📞 Need Help?

1. **Can't login?** → Check username with `whoami`
2. **Can't access?** → Check service: `sudo systemctl status rstudio-server`
3. **Port issues?** → See INSTALLATION_QUICK_REFERENCE.txt
4. **More details?** → See INSTALLATION_WALKTHROUGH.md

---

## 🎉 You're All Set!

**What you have:**
✅ R installation
✅ RStudio Server (web IDE)
✅ 20+ pre-installed packages
✅ Professional development environment
✅ Everything documented

**What's next:**
1. Open http://localhost:8787
2. Login
3. Start analyzing data!

**Happy coding! 🚀**
