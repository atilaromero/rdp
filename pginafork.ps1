choco install -y pginafork
stop-service -name pgina
cmd /C "regedit /s C:\pginafork.reg"
del C:\pginafork.reg
start-service -name pgina
