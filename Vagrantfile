# -*- mode: ruby -*-
# vi: set ft=ruby :

# $provision = <<SHELL
# yum -y install https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# yum -y install perl perl-Net-IP perl-NetAddr-IP perl-Net-Netmask perl-JSON
# SHELL

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "chef/centos-7.0"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--cpus", 2]
    vb.customize ["modifyvm", :id, "--memory", 1536]
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: "/vagrant/provision.sh"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :machine
  end

end
