# Load the System.Windows.Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a new NotifyIcon object
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon

# Set the Icon property to a .ico file
$notifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("kick.ico")

# Set the Text property to display as a tooltip
$notifyIcon.Text = "KICKstand - Native Bot for KICK"

# Display the NotifyIcon in the system tray
$notifyIcon.Visible = $true

# Create a context menu for the NotifyIcon
$contextMenu = New-Object System.Windows.Forms.ContextMenu
$menuItem = New-Object System.Windows.Forms.MenuItem
$menuItem.Text = "Exit"
$menuItem.Add_Click({
        $notifyIcon.Visible = $false
        $notifyIcon.Dispose()
        [System.Windows.Forms.Application]::Exit()
    })
$contextMenu.MenuItems.Add($menuItem)
$notifyIcon.ContextMenu = $contextMenu

# Keep the script running until the user closes the NotifyIcon
[System.Windows.Forms.Application]::Run()
