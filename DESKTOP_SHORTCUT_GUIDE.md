# Desktop Shortcut & Standalone App Guide

This guide will help you create a desktop shortcut or standalone app launcher for the Clinic Visit Tracker, so you can launch it with a single click!

## Quick Start

Choose the method for your operating system:

- **Linux**: [Linux Desktop Shortcut](#linux-desktop-shortcut)
- **Windows**: [Windows Desktop Shortcut](#windows-desktop-shortcut)
- **macOS**: [macOS Desktop Launcher](#macos-desktop-launcher)

---

## Linux Desktop Shortcut

### Method 1: Using the Provided Desktop File (Easiest)

1. **Copy the desktop file to your desktop**:
   ```bash
   cp ClinicTracker.desktop ~/Desktop/
   ```

2. **Make it executable** (if not already):
   ```bash
   chmod +x ~/Desktop/ClinicTracker.desktop
   ```

3. **Trust the launcher**:
   - Right-click on the `ClinicTracker.desktop` file on your desktop
   - Select "Allow Launching" or "Trust and Launch" (depends on your desktop environment)

4. **Double-click to launch**!

### Method 2: Add to Applications Menu

To add it to your system applications menu:

```bash
# Copy to applications folder
sudo cp ClinicTracker.desktop /usr/share/applications/

# Or for current user only
mkdir -p ~/.local/share/applications
cp ClinicTracker.desktop ~/.local/share/applications/
```

Now you can search for "Clinic Visit Tracker" in your applications menu!

### Method 3: Direct Script Launch

Simply double-click `launch_app.sh` from your file manager, or run:
```bash
./launch_app.sh
```

---

## Windows Desktop Shortcut

### Method 1: Using the VBS Silent Launcher (Recommended)

The VBS launcher runs the app without showing a console window - cleaner experience!

1. **Right-click on `launch_app.vbs`**
2. **Select "Send to" → "Desktop (create shortcut)"**
3. **Optional**: Right-click the shortcut on your desktop → "Properties" → "Change Icon" to customize
4. **Double-click the shortcut** to launch!

### Method 2: Using the Batch File

1. **Right-click on `launch_app.bat`**
2. **Select "Send to" → "Desktop (create shortcut)"**
3. **Double-click the shortcut** to launch (will show a console window)

### Method 3: Create a Taskbar Shortcut

1. Create a desktop shortcut using Method 1 or 2
2. **Right-click the desktop shortcut**
3. **Select "Pin to taskbar"**
4. Now you can launch from your taskbar!

### Windows Startup (Auto-launch on boot)

To automatically start the app when Windows starts:

1. Press `Win + R` to open Run dialog
2. Type `shell:startup` and press Enter
3. Copy `launch_app.vbs` (or create a shortcut to it) into this folder
4. The app will now launch automatically when you log in!

---

## macOS Desktop Launcher

### Method 1: Using the .command File (Simplest)

1. **Double-click `ClinicTracker.app.command`** to launch
2. The first time, you may need to:
   - Right-click → "Open"
   - Click "Open" in the security dialog
3. **Optional**: Drag `ClinicTracker.app.command` to your Dock for easy access

### Method 2: Create an Application Bundle (Most Mac-like)

For a true macOS app experience:

1. Open **Automator** (in Applications/Utilities)
2. Choose **"Application"**
3. Search for and add **"Run Shell Script"** action
4. Paste this script:
   ```bash
   cd "/path/to/CoffeeBeansFork"
   ./launch_app.sh
   ```
   Replace `/path/to/CoffeeBeansFork` with the actual path!
5. Save as **"Clinic Visit Tracker"** in your Applications folder
6. **Optional**: Right-click the app → "Get Info" → drag a custom icon onto the icon in the top-left

Now it appears as a regular Mac app!

### Method 3: Add to Login Items (Auto-launch)

To start the app automatically when you log in:

1. Open **System Preferences** → **Users & Groups**
2. Click your username
3. Click **"Login Items"** tab
4. Click the **"+"** button
5. Navigate to and select `ClinicTracker.app.command` (or your Automator app)
6. It will now launch automatically when you log in!

---

## Customizing Your Launcher

### Adding a Custom Icon

#### Linux:
1. Find a PNG image you want to use
2. Save it as `clinic_tracker_icon.png` in the app folder
3. Edit `ClinicTracker.desktop`:
   ```
   Icon=/home/user/CoffeeBeansFork/clinic_tracker_icon.png
   ```

#### Windows:
1. Find an ICO file (or convert a PNG to ICO using an online tool)
2. Right-click your desktop shortcut → "Properties"
3. Click "Change Icon" → "Browse"
4. Select your ICO file

#### macOS:
1. Find an ICNS file or any image
2. Copy the image (Cmd+C)
3. Right-click your app → "Get Info"
4. Click the small icon in the top-left
5. Paste (Cmd+V)

---

## Advanced: Creating a True Standalone Executable

For a completely standalone app that doesn't require Python installed:

### PyInstaller Method (All Platforms)

1. **Install PyInstaller**:
   ```bash
   pip install pyinstaller
   ```

2. **Create the executable**:
   ```bash
   pyinstaller --onefile --windowed --name "ClinicTracker" app.py
   ```

3. **Find your executable** in the `dist/` folder

4. **Note**: The executable will be large (50-100MB) because it includes Python and all dependencies

### Docker Method (Advanced)

For a containerized version that works anywhere:

```bash
# Build the container
docker build -t clinic-tracker .

# Run it
docker run -p 5000:5000 -v $(pwd)/clinic_tracker.db:/app/clinic_tracker.db clinic-tracker

# Open browser to http://localhost:5000
```

---

## Troubleshooting

### "Permission Denied" Error
Make sure the launch scripts are executable:
```bash
chmod +x launch_app.sh
chmod +x ClinicTracker.app.command
```

### Python Not Found
- **Linux**: Install Python 3: `sudo apt install python3 python3-venv`
- **Windows**: Download from [python.org](https://www.python.org/downloads/)
- **macOS**: Install from [python.org](https://www.python.org/downloads/) or use Homebrew: `brew install python3`

### Browser Doesn't Open Automatically
The app is still running! Manually open your browser to:
```
http://127.0.0.1:5000
```

### App Won't Stop
- **Linux/macOS**: Press `Ctrl+C` in the terminal
- **Windows**: Close the console window or press any key if prompted
- **Or**: Open Task Manager/Activity Monitor and kill the Python process

### Port 5000 Already in Use
Another app is using port 5000. Edit `app.py` and change this line:
```python
app.run(debug=False, host='0.0.0.0', port=5000)
```
to use a different port like 5001:
```python
app.run(debug=False, host='0.0.0.0', port=5001)
```

---

## Multiple Installations

You can have the app in multiple locations! Just copy the entire folder and create separate shortcuts. Each instance will have its own database.

Example use cases:
- Work computer
- Home computer
- Laptop
- USB drive (portable version)

---

## Updates

When you update the app code:
1. Delete the `.requirements_installed` file
2. Launch the app - it will reinstall dependencies automatically

Or manually update:
```bash
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt --upgrade
```

---

## Need Help?

Refer to the main [README.md](README.md) for app usage instructions.

Happy tracking!
