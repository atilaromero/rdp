# -*- mode: ruby -*-
# vi: set ft=ruby :

NAME=ENV['NAME'] || "RDP7"
PORT=ENV['PORT'] || 33890
MEMORY=ENV['MEMORY'] || 16384
PASSWORD=ENV['PASSWORD'] || rand(1000000000)

Vagrant.configure(2) do |config|
  config.vm.box = "ferventcoder/win2012r2-x64-nocm"
  #config.vm.box = "opentable/win-7-professional-amd64-nocm"
  config.vm.hostname = "win2012"
  config.vm.communicator = "winrm"

  config.vm.provider "virtualbox" do |vb|
        vb.memory = MEMORY
        vb.cpus = 2
        vb.customize ["modifyvm", :id, "--vram", "128"]
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.name = NAME
  end 
  #config.vm.network "public_network", bridge: "br0"
  #config.vm.network "private_network", ip: "10.0.2.15"
  config.vm.network "forwarded_port", guest: 3389, host: PORT, auto_correct: true
  config.vm.synced_folder '.', '/vagrant', disabled: true
  if File.exist?("./cache/")
    Dir.foreach("./cache/") do |f|
      next if f == '.' or f == '..' or f == '.keep'
      config.vm.provision "file", source: "./cache/#{f}", destination:"C:\\Users\\Administrator\\AppData\\Local\\Temp\\chocolatey\\#{f}"
    end
  end
  ["Operacoes.lnk", "Mount Operacoes.bat"].each do |f|
    config.vm.provision "file", source: "#{f}", destination: "C:\\Users\\Public\\Desktop\\#{f}"
  end
  config.vm.provision "file", source: "pginafork.reg", destination: "C:\\pginafork.reg"
  config.vm.provision "file", source: "./ufed-reader", destination: "C:\\Users\\Administrator\\AppData\\Local\\Temp\\ufed-reader"

  config.vm.provision "shell", inline: <<-SHELL
    # install choco
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
    
    mv C:\\Users\\Administrator\\AppData\\Local\\Temp\\chocolatey\\*.nupkg C:\\Users\\Administrator\\AppData\\Local\\NuGet\\Cache\\

    choco install -y javaruntime
    choco install -y firefox
    choco install -y googlechrome
    choco install -y vlc

    Set-ItemProperty -Path "HKLM:\\System\\CurrentControlSet\\Control\\Terminal Server" -Name "fDenyTSConnections" -Value 0

    # RDP MaxDisconnection time: 432000000 = 5 days
    Set-ItemProperty -Path "HKLM:\\System\\CurrentControlSet\\Control\\Terminal Server\\WinStations\\RDP-Tcp" -Name "MaxDisconnectionTime" -Value 432000000
    Set-ItemProperty -Path "HKLM:SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services" -Name "MaxDisconnectionTime" -Value 432000000
    Set-ItemProperty -Path "HKLM:SOFTWARE\\Wow6432Node\\Policies\\Microsoft\\Windows NT\\Terminal Services" -Name "MaxDisconnectionTime" -Value 432000000

    # RDP Security layer: RDP
    Set-ItemProperty -Path "HKLM:\\System\\CurrentControlSet\\Control\\Terminal Server\\WinStations\\RDP-Tcp" -Name "SecurityLayer" -Value 0
    Set-ItemProperty -Path "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services" -Name "SecurityLayer" -Value 0
    Set-ItemProperty -Path "HKLM:\\SOFTWARE\\Wow6432Node\\Policies\\Microsoft\\Windows NT\\Terminal Services" -Name "SecurityLayer" -Value 0

    # RDP UserAuthentication: not required
    Set-ItemProperty -Path "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services" -Name "UserAuthentication" -Value 0
    Set-ItemProperty -Path "HKLM:\\SOFTWARE\\Wow6432Node\\Policies\\Microsoft\\Windows NT\\Terminal Services" -Name "UserAuthentication" -Value 0

    choco install -y pginafork
    stop-service -name pgina
    cmd /C "regedit /s C:\\pginafork.reg"
    del C:\\pginafork.reg
    start-service -name pgina
    
    choco install ufed-reader -s C:\\Users\\Administrator\\AppData\\Local\\Temp\\ufed-reader
  SHELL
  config.vm.provision "shell", inline: <<-SHELL
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    start-job {start-sleep 10; net user vagrant #{PASSWORD}; Restart-Computer -Force}
  SHELL
end

