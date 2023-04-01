param(
    [string]$ip = "localhost",
    [int]$port = 9222
)

$remoteDebuggingUrl = "http://${ip}:${port}"

function Test-Port ($hostname, $port, $timeout = 1000) {
    try {
        $connection = Test-Connection -ComputerName $hostname -Port $port -Delay $timeout -Count 1 -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

if (-not (Test-Port -hostname $ip -port $port)) {
    Write-Host "Nothing running on port $port."
    #exit
}

function ListenForWebSockets ($remoteDebuggingUrl) {
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


function Speak-Text {
    param($Text)
    Add-Type -AssemblyName System.Speech
    $speechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $speechSynthesizer.Speak($Text)
}

Add-Type -AssemblyName System.Windows.Forms

# Create a context menu with two sections and an Exit item
$contextMenu = New-Object System.Windows.Forms.ContextMenuStrip
$section1 = $contextMenu.Items.Add("Section 1 - Lorem Ipsum")
$section2 = $contextMenu.Items.Add("Section 2 - Hello World")

$separator = New-Object System.Windows.Forms.ToolStripSeparator
[void]$contextMenu.Items.Add($separator)

$exitItem = $contextMenu.Items.Add("Exit")

# Define actions for each section and the Exit item
$section1.Add_Click({ Write-Host "Section 1 - Lorem Ipsum clicked" })
$section2.Add_Click({ Write-Host "Section 2 - Hello World clicked" })
$exitItem.Add_Click({
        $notifyIcon.Visible = $false
        $contextMenu.Dispose()
        [System.Windows.Forms.Application]::Exit()
        exit
    })

# Create a system tray icon and associate the context menu with it
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
#$notifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName)
$scriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$iconPath = Join-Path -Path $scriptPath -ChildPath "kick.ico"
$notifyIcon.Icon = New-Object System.Drawing.Icon -ArgumentList $iconPath
$notifyIcon.ContextMenuStrip = $contextMenu
$notifyIcon.Visible = $true

# Create a custom ApplicationContext to keep the script running
$context = New-Object System.Windows.Forms.ApplicationContext
[System.Windows.Forms.Application]::Run($context)




# Speak-Text -Text "Hello, I am a text-to-speech system in PowerShell"
