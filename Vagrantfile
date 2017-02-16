# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|

  #!!--Begin Single-Node Spark config--!!#
  # vagrant up single
  config.vm.define :single do |master|
	master.vm.box = "bento/ubuntu-16.04"
	master.vm.provision "shell", path: "systemSetup.sh"
	master.vm.provider "virtualbox" do |vb|
		vb.memory="2048"
		vb.cpus = "2"
	end
	master.vm.network "forwarded_port", guest: 8787, host: 8787 #RStudio
	master.vm.network "forwarded_port", guest: 4040, host: 8081 #Spark Web UI
	#master.vm.network "private_network", ip: "192.168.1.100"
  end
  #!!--End Single-Node Spark config--!!#

  #!!--Begin spark cluster configs--!!#
  ## This is a master node for the cluster.
  # vagrant up master
  config.vm.define :master do |master|
	master.vm.box = "bento/ubuntu-16.04"
	master.vm.provision "shell", path: "masterSetup.sh"
	master.vm.provider "virtualbox" do |vb|
		vb.memory="2048"
		vb.cpus = "2"
	end
	master.vm.network "forwarded_port", guest: 8787, host: 8787 #RStudio
	master.vm.network "forwarded_port", guest: 4040, host: 8081 #Spark Master Web UI
	master.vm.network "private_network", ip: "10.2.0.15"
  end

  ## This is a follower node for the cluster.
  # vagrant up follower
  config.vm.define :follower do |follower|
	follower.vm.box = "bento/ubuntu-16.04"
	follower.vm.provision "shell", path: "followerSetup.sh"
	follower.vm.provider "virtualbox" do |vb|
		vb.memory="2048"
		vb.cpus="2"
	end
	follower.vm.network "forwarded_port", guest: 4040, host: 8082 #Spark Worker Web UI
	follower.vm.network "private_network", ip: "10.2.0.16"
  end
  #!!--End spark cluster configs--!!#

end
