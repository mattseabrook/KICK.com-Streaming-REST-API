Dim objFSO, objShell, strScriptPath

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

strScriptPath = objFSO.GetParentFolderName(WScript.ScriptFullName) & "\KICKstand.ps1"

objShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & strScriptPath & """", 0, True

Set objFSO = Nothing
Set objShell = Nothing
