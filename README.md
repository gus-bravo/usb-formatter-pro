# USB Formatter Pro

A PowerShell script to safely format and prepare USB drives using DiskPart.

## 📦 Features

- Lists all connected disks with number, name, size, and partition style.
- Prompts user to select the disk number.
- Shows detailed information about the selected disk.
- Requires manual confirmation before making any changes.
- Creates and runs a temporary DiskPart script to clean and format the drive.

## ⚠️ Warning

> **Use this script carefully!**  
> Selecting the wrong disk number may result in data loss.  
> Always double-check the disk information before confirming.

## ✅ Requirements

- Windows operating system.
- Run as Administrator (required by DiskPart).

## 🚀 Usage

1. Open PowerShell as Administrator.
2. Navigate to the folder containing the script.
3. Run the script:

   ```powershell
   ./usb-formatter-pro.ps1

   ```

4. Follow the prompts:
   Review the list of disks.
   Enter the number of your USB drive.
   Confirm by typing YES when asked.

## 📄 License

This project is open-source.
Feel free to use, modify, and share under the terms of your preferred license.
