Set oWS = WScript.CreateObject("WScript.Shell")
sLinkFile = "Operacoes.lnk"
Set oLink = oWS.CreateShortcut(sLinkFile)
    oLink.TargetPath = "Z:\"
 '  oLink.Arguments = ""
 '  oLink.Description = "Operacoes"
 '  oLink.HotKey = "ALT+CTRL+F"
 '  oLink.IconLocation = "C:\Program Files\MyApp\MyProgram.EXE, 2"
 '  oLink.WindowStyle = "1"
 '  oLink.WorkingDirectory = "Z:\"
oLink.Save