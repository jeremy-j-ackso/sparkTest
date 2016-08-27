# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|

  config.vm.define :master do |master|
	master.vm.box = "ubuntu/trusty64"
	master.vm.provision "shell", path: "masterSetup.sh"
	master.vm.provider "virtualbox" do |vb|
		vb.memory="2048"
		vb.cpus = "2"
	end
	master.vm.network "forwarded_port", guest: 8787, host: 8787
	master.vm.network "forwarded_port", guest: 8080, host: 8081
	master.vm.network "private_network", ip: "192.168.1.100"
  end

  config.vm.define :follower do |follower|
	follower.vm.box = "ubuntu/trusty64"
	follower.vm.provision "shell", path: "followerSetup.sh"
	follower.vm.provider "virtualbox" do |vb|
		vb.memory="2048"
		vb.cpus="2"
	end
	follower.vm.network "forwarded_port", guest: 8081, host: 8082
	follower.vm.network "private_network", ip: "192.168.1.101"
  end

end
