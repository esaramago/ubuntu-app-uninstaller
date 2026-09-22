# Ubuntu App Uninstaller

A lightweight Bash utility with a **Zenity** GUI to easily search for and uninstall **APT**, **Snap**, and **Flatpak** packages on Ubuntu.

---

## 📋 Prerequisites

Before testing or building the package, ensure the required dependencies are installed:

```bash
sudo apt update
sudo apt install zenity gnome-terminal dpkg
```

> **Note:** To search and remove Snap or Flatpak packages, make sure `snapd` and `flatpak` are installed and configured on your system.

---

## 🧪 Testing (Development Mode)

You can run and test the script directly without building or installing the package:

1. Grant execute permissions to the script:
   ```bash
   chmod +x usr/local/bin/uninstaller
   ```

2. Run the script:
   ```bash
   ./usr/local/bin/uninstaller
   ```

---

## 📦 Building / Packaging the Debian Package (`.deb`)

This application is written in Bash and does not require binary compilation, but it needs to be **packaged** into a `.deb` file for distribution and system-wide installation.

### 1. Set File Permissions
Ensure all directories and files have the appropriate permissions before building:

```bash
chmod 755 DEBIAN
chmod 644 DEBIAN/control
chmod 755 usr/local/bin/uninstaller
chmod 644 usr/share/applications/unninstaller.desktop
```

### 2. Build the `.deb` Package
From the project root directory (`ubuntu-app-uninstaller`), run:

```bash
dpkg-deb --root-owner-group --build . ../uninstaller_1.0_all.deb
```

This creates `uninstaller_1.0_all.deb` in the parent directory.

To build it inside the current directory instead:
```bash
dpkg-deb --root-owner-group --build . uninstaller_1.0_all.deb
```

---

## 🚀 Installation

Install the generated `.deb` package using `apt`:

```bash
sudo apt install ./uninstaller_1.0_all.deb
```
*(Using `apt` automatically resolves and installs any missing runtime dependencies, such as `zenity`).*

---

## 🖥️ Running the Application

- **Via Terminal:**
  ```bash
  uninstaller
  ```
- **Via Application Menu:**
  Search for **"Uninstaller"** in the GNOME Application Menu / Ubuntu Dash.

---

## 🗑️ Uninstallation

To remove the application from your system:

```bash
sudo apt remove uninstaller
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.