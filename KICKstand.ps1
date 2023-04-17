# KICKstand.ps1
#
# Author: Matt Seabrook
# Email: info@mattseabrook.net
# Discord: Matthew Seabrook#6243
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
# (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, 
# publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do 
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

$ini = @"
; KICKstand configuration file

[config]
commandsEnabled=false
ttsEnabled=false

[browser]
ip=127.0.0.1
port=9222
"@


<#
    .SYNOPSIS
        About Dialog window

    .DESCRIPTION
        Displays a dialog window with information about the application, as well as links to the source code and documentation.
#>
function about {
    Add-Type -AssemblyName System.Windows.Forms
    $aboutBox = New-Object System.Windows.Forms.Form
    $aboutBox.Text = "KICKstand v.0.1"
    $aboutBox.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow
    $aboutBox.MaximizeBox = $false
    $aboutBox.MinimizeBox = $false
    $aboutBox.StartPosition = "CenterScreen"
    $aboutBox.ClientSize = New-Object System.Drawing.Size(300, 200)

    $panel = New-Object System.Windows.Forms.Panel
    $panel.Dock = [System.Windows.Forms.DockStyle]::Fill
    $panel.AutoScroll = $true
    $aboutBox.Controls.Add($panel)

    $table = New-Object System.Windows.Forms.TableLayoutPanel
    $table.RowCount = 4
    $table.ColumnCount = 1
    $table.Dock = [System.Windows.Forms.DockStyle]::Top
    $table.AutoSize = $true
    $table.Margin = New-Object System.Windows.Forms.Padding(10)

    $label1 = New-Object System.Windows.Forms.Label
    $label1.Text = "Author: Matt Seabrook"
    $label1.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
    $label1.AutoSize = $true
    $table.Controls.Add($label1, 0, 0)

    $label2 = New-Object System.Windows.Forms.Label
    $label2.Text = "Email: info@mattseabrook.net"
    $label2.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
    $label2.AutoSize = $true
    $table.Controls.Add($label2, 0, 1)

    $label3 = New-Object System.Windows.Forms.Label
    $label3.Text = "Discord: Matthew Seabrook#6243"
    $label3.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
    $label3.AutoSize = $true
    $label3.Padding = New-Object System.Windows.Forms.Padding(0, 0, 0, 20)
    $table.Controls.Add($label3, 0, 2)

    $panel.Controls.Add($table)

    $linkLabel = New-Object System.Windows.Forms.LinkLabel
    $linkLabel.Text = "KICKstand on GitHub"
    $linkLabel.AutoSize = $true
    $linkLabel.Location = New-Object System.Drawing.Point(($aboutBox.ClientSize.Width - $linkLabel.Width) / 2, $table.Bottom + 20)
    $linkLabel.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Underline)
    $linkLabel.LinkBehavior = [System.Windows.Forms.LinkBehavior]::HoverUnderline
    $linkLabel.LinkColor = [System.Drawing.Color]::Blue
    $linkLabel.ActiveLinkColor = [System.Drawing.Color]::Blue
    $linkLabel.VisitedLinkColor = [System.Drawing.Color]::Purple
    $linkLabel.Links.Add(0, $linkLabel.Text.Length,"https://github.com/mattseabrook/KICKstand")
    $linkLabel.Add_Click({
    [System.Diagnostics.Process]::Start($linkLabel.Links[$linkLabel.Links.IndexOf($linkLabel.Links[0])].LinkData)
    })
    $table.Controls.Add($linkLabel, 0, 3)
    
    $button = New-Object System.Windows.Forms.Button
    $button.Text = "OK"
    $button.Width = 80
    $button.Height = 25
    $button.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $button.Dock = [System.Windows.Forms.DockStyle]::Bottom
    $aboutBox.AcceptButton = $button
    $aboutBox.Controls.Add($button)

    $aboutBox.ShowDialog()
}


<#
    .SYNOPSIS
        A function to check if a service is running on a given port.

    .DESCRIPTION
        This function takes a string (IP Address) and integer (Port Number) as input and checks if a service is running.

    .PARAMETER hostname
        IP Address in string format such as "127.0.0.1"

    .PARAMETER port
        Port Number in integer format such as 9222
#>
function Test-Port ($ip, $port) {
    try {
        $connection = Test-Connection -ComputerName $ip -Port $port -Delay 1000 -Count 1 -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}


<#
    .SYNOPSIS
        Connects to a Chrome instance via the Remote Debugging Protocol and listens for WebSocket messages.

    .DESCRIPTION
        LOREM IPSUM
#>
function ListenForWebSockets {
    $remoteDebuggingUrl = "http://${ip}:${port}"    # To be removed later

    # Import necessary namespaces
    Add-Type -AssemblyName System.Web.Extensions

    # Function to send WebSocket JSON messages
    function Send-WebSocketMessage ($WebSocket, $message) {
        $json = (ConvertTo-Json $message)
        $WebSocket.SendAsync([System.Text.Encoding]::UTF8.GetBytes($json), [System.Net.WebSockets.WebSocketMessageType]::Text, $true, [Threading.CancellationToken]::None)
    }

    # Get the list of available browser tabs
    $response = Invoke-WebRequest -Uri "$remoteDebuggingUrl/json"
    $tabs = $response.Content | ConvertFrom-Json

    # Find the first available tab
    $tab = $tabs[0]
    $webSocketDebuggerUrl = $tab.webSocketDebuggerUrl

    # Create a WebSocket connection and enable the Network domain
    $WebSocket = [System.Net.WebSockets.ClientWebSocket]::new()
    $WebSocket.ConnectAsync($webSocketDebuggerUrl, [Threading.CancellationToken]::None).Wait()
    Send-WebSocketMessage -WebSocket $WebSocket -message @{ id = 1; method = "Network.enable" }

    # Listen for WebSocket traffic and print the content of the WebSocket messages
    $buffer = [System.Byte[]]::new(8192)
    while ($true) {
        $response = $WebSocket.ReceiveAsync($buffer, [Threading.CancellationToken]::None).Result
        $rawData = $buffer[0..($response.Count - 1)] -join " "
        $message = [System.Text.Encoding]::UTF8.GetString($rawData) | ConvertFrom-Json

        if ($message.method) {
            switch ($message.method) {
                'Network.webSocketCreated' { Write-Host "WebSocket URL: $($message.params.url)" }
                'Network.webSocketClosed' { Write-Host "WebSocket closed: $($message.params.url)" }
                'Network.webSocketFrameSent' { Write-Host "Sent WebSocket data: $($message.params.response.payloadData)" }
                'Network.webSocketFrameReceived' { Write-Host "Received WebSocket data: $($message.params.response.payloadData)" }
            }
        }
    }
}


<#
    .SYNOPSIS
        Enables the Context Menu

    .DESCRIPTION
        This function builds and populates the Context Menu for the KICKstand icon in the system tray, and defines what happens the user clicks on a Context Menu item.
#>
function contextMenu {
    $commands = $state.contextMenu.Items.Add("Commands")
    $tts = $state.contextMenu.Items.Add("TTS")

    $separator = New-Object System.Windows.Forms.ToolStripSeparator
    [void]$state.contextMenu.Items.Add($separator)

    $help = $state.contextMenu.Items.Add("Help")
    $about = $state.contextMenu.Items.Add("About")

    $separator2 = New-Object System.Windows.Forms.ToolStripSeparator
    [void]$state.contextMenu.Items.Add($separator2)

    $exitItem = $state.contextMenu.Items.Add("Exit")

    # Channel Commands
    $commands.Add_Click({
        if ($commands.Checked) {
            $commands.Checked = $false
        } else {
            $commands.Checked = $true
        }
    })

    # Text-to-Speech
    $tts.Add_Click({
        if ($tts.Checked) {
            $tts.Checked = $false
        } else {
            $tts.Checked = $true
        }
    })

    # Help
    $help.Add_Click({
        $url = "https://github.com/mattseabrook/KICKstand#usage"
        Start-Process $url
    })

    # About
    $about.Add_Click({
        about
    })

    # Exit
    $exitItem.Add_Click({
        $notifyIcon.Visible = $false
        $contextMenu.Dispose()
        [System.Windows.Forms.Application]::Exit()
        exit
    })
}


# Speak-Text -Text "Hello, I am a text-to-speech system in PowerShell"
function Speak-Text {
    param($Text)
    Add-Type -AssemblyName System.Speech
    $speechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $speechSynthesizer.Speak($Text)
}


#
# INIT
#
Add-Type -AssemblyName System.Windows.Forms

# Object to manage application state
$state = New-Object -TypeName System.Management.Automation.PSObject

# Static application state members
$state | Add-Member -MemberType NoteProperty -Name "context" -Value (New-Object System.Windows.Forms.ApplicationContext)
$state | Add-Member -MemberType NoteProperty -Name "contextMenu" -Value (New-Object System.Windows.Forms.ContextMenuStrip)
$state | Add-Member -MemberType NoteProperty -Name "tempFolder" -Value "$env:USERPROFILE\temp\KICKstand"
$state | Add-Member -MemberType NoteProperty -Name "pidFile" -Value "$state:tempFolder\PID"
$state | Add-Member -MemberType NoteProperty -Name "notifyIcon" -Value (New-Object System.Windows.Forms.NotifyIcon)
$state | Add-Member -MemberType NoteProperty -Name "workingDir" -Value (Split-Path -Parent -Path $MyInvocation.MyCommand.Definition)
$state | Add-Member -MemberType NoteProperty -Name "ini" -Value "$env:USERPROFILE\KICKstand.ini"
$state | Add-Member -MemberType NoteProperty -Name "config" -Value (New-Object -TypeName System.Management.Automation.PSObject)

# Application configuration
$state.config | Add-Member -MemberType NoteProperty -Name "browser" -Value "Brave"
$state.config | Add-Member -MemberType NoteProperty -Name "ip" -Value "127.0.0.1"
$state.config | Add-Member -MemberType NoteProperty -Name "port" -Value 9222

# Create a system tray icon and associate the context menu with it
$state.notifyIcon.Icon = New-Object System.Drawing.Icon -ArgumentList (Join-Path -Path $state.workingDir -ChildPath "kick.ico")
$state.notifyIcon.ContextMenuStrip = $state.ContextMenu
$state.notifyIcon.Visible = $true
$state.notifyIcon.Text = "KICKstand v.0.1"

# Handle the temp directory
if (-not (Test-Path $state.tempFolder)) {
    New-Item -ItemType Directory -Path $state.tempFolder
}
if (-not (Test-Path $state.pidFile)) {
    New-Item -ItemType File -Path $state.pidFile
}
Set-Content -Path $state.pidFile -Value $PID

# Set up the Context Menu
contextMenu

# State
# Set Checked property for Command 1 and TTS Option 1
$commands.Checked = $true
$tts.Checked = $true


# to be removed later into it's own function
if (-not (Test-Port -hostname $state.config.ip -port $state.config.port)) {
    Write-Host "Nothing running on specified IP and Port..."
    #exit
}


# Create a custom ApplicationContext to keep the script running
[System.Windows.Forms.Application]::Run($state.Context)