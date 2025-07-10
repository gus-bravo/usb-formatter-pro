# ╔════════════════════════════════════════════════════════════╗
# ║           USB Formatter Pro - Safe USB Disk Tool 🚀       ║
# ╚════════════════════════════════════════════════════════════╝

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

# ✅ Check for administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "⚠️ Please run this script as Administrator to use DiskPart." -ForegroundColor Red
    exit
}

# ✅ Display detected disks using Get-Disk
Write-Host ""
Write-Host "🔍 Disks detected by PowerShell:" -ForegroundColor Cyan
Get-Disk | Select-Object Number, FriendlyName, Size, PartitionStyle | Format-Table

Write-Host ""
Write-Host "💽 DiskPart will also open if you'd like to compare manually..." -ForegroundColor Cyan
Pause

Start-Process diskpart -Wait

Write-Host ""
Write-Host "✅ Close DiskPart and return here to continue." -ForegroundColor Yellow
Pause

# ✅ Ask for the disk number and validate input
do {
    $disknum = Read-Host "🧠 Enter the disk number of your USB drive"
} while (-not ($disknum -match '^\d+$'))

# ✅ Retrieve info about the selected disk
$disk = Get-Disk -Number $disknum -ErrorAction SilentlyContinue

if ($null -eq $disk) {
    Write-Host "❌ Disk number $disknum was not found. Please check and try again." -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "📊 Selected disk:"
Write-Host "Number:     $($disk.Number)"
Write-Host "Name:       $($disk.FriendlyName)"
Write-Host "Size:       $([Math]::Round($disk.Size/1GB, 2)) GB"
Write-Host "Partition:  $($disk.PartitionStyle)"
Write-Host ""
Write-Host "⚠️ Make sure this is your USB drive and not another disk." -ForegroundColor Red

# ✅ Confirm before proceeding
$confirm = Read-Host "✏️ Type 'YES' to continue, or anything else to cancel"
if ($confirm -ne "YES") {
    Write-Host "❌ Operation canceled. No changes were made. 👌" -ForegroundColor Yellow
    exit
}

# ✅ Create temporary DiskPart script
$diskpartCommands = @"
select disk $disknum
clean
create partition primary
select partition 1
active
format fs=fat32 quick
assign
"@

$scriptPath = "$env:TEMP\diskpart_script.txt"
$diskpartCommands | Out-File -FilePath $scriptPath -Encoding ASCII  # DiskPart requires ASCII

# ✅ Run DiskPart to format the USB drive
Write-Host ""
Write-Host "⚙️ Formatting the USB drive... 🚀💾" -ForegroundColor Green
Pause

Start-Process diskpart -ArgumentList "/s `"$scriptPath`"" -Wait

# ✅ Clean up temporary script
Remove-Item $scriptPath -Force

Write-Host ""
Write-Host "✅ USB drive formatted successfully. Ready to use! 🛸✨" -ForegroundColor Green
Pause