# -*- mode: ruby -*-
# vi: set ft=ruby :

NAME=ENV['NAME'] || "RDP7"
PORT=ENV['PORT'] || 33890

Vagrant.configure(2) do |config|
  config.vm.box = "ferventcoder/win2012r2-x64-nocm"
  #config.vm.box = "opentable/win-7-professional-amd64-nocm"
  config.vm.hostname = "win2012"
  config.vm.communicator = "winrm"

  config.vm.provider "virtualbox" do |vb|
        vb.memory = "16384"
        vb.cpus = 2
        vb.customize ["modifyvm", :id, "--vram", "128"]
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.name = NAME
  end 
  #config.vm.network "public_network", bridge: "br0"
  #config.vm.network "private_network", ip: "10.0.2.15"
  config.vm.network "forwarded_port", guest: 3389, host: PORT, auto_correct: true
  config.vm.synced_folder '.', '/vagrant', disabled: true
  ["jre8", "pginafork"].each do |f|
    config.vm.provision "file", source: "./cache/#{f}", destination:"C:\\Users\\Administrator\\AppData\\Local\\Temp\\chocolatey\\#{f}"
  end
  ["Operacoes.lnk", "Mount Operacoes.bat"].each do |f|
    config.vm.provision "file", source: "#{f}", destination: "C:\\Users\\Public\\Desktop\\#{f}"
  end
  config.vm.provision "file", source: "pginafork.reg", destination: "C:\\pginafork.reg"

  config.vm.provision "shell", path: 'chocoinstall.ps1'
  config.vm.provision "shell", path: 'packages.ps1'
  config.vm.provision "shell", path: 'rdp.ps1'
  config.vm.provision "shell", path: 'pginafork.ps1', privileged: "true", powershell_elevated_interactive: "true"
end
