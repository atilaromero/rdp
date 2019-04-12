# -*- mode: ruby -*-
# vi: set ft=ruby :

$script1 = 
$script2 = 
$script3 = 

Vagrant.configure(2) do |config|
  config.vm.box = "ferventcoder/win2012r2-x64-nocm"
  config.vm.hostname = "win2012"
  config.vm.communicator = "winrm"

  config.vm.provider "virtualbox" do |vb|
        vb.memory = "16384"
        vb.cpus = 2
        vb.customize ["modifyvm", :id, "--vram", "128"]
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.name = "RDP"   
  config.vm.provision "shell", inline: File.read('./chocoinstall.ps1')
  config.vm.provision "shell", inline: File.read('./packages.bat')
  config.vm.provision "shell", inline: File.read('./share.bat')
  end 
end
