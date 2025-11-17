' Clinic Visit Tracker Silent Launcher for Windows
' This launches the app without showing a console window

Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Get the directory where this script is located
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Change to script directory
WshShell.CurrentDirectory = scriptDir

' Launch the batch file hidden
WshShell.Run """" & scriptDir & "\launch_app.bat""", 0, False

' Show notification (if supported)
Set objNotify = CreateObject("WScript.Shell")
objNotify.Popup "Clinic Visit Tracker is starting..." & vbCrLf & "Opening in your browser...", 3, "Clinic Visit Tracker", 64
