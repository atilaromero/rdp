Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

#432000000 = 5 days
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "MaxDisconnectionTime" -Value 432000000
Set-ItemProperty -Path "HKLM:SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "MaxDisconnectionTime" -Value 432000000
Set-ItemProperty -Path "HKLM:SOFTWARE\Wow6432Node\Policies\Microsoft\Windows NT\Terminal Services" -Name "MaxDisconnectionTime" -Value 432000000


Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "SecurityLayer" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows NT\Terminal Services" -Name "SecurityLayer" -Value 0

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name "UserAuthentication" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows NT\Terminal Services" -Name "UserAuthentication" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
