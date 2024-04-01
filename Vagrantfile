# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define how much memory your computer has in GB (e.g. 8, 16)
# Larger nodes will be created if you have more.
RAM_SIZE = 16

# Define how mnay CPU cores you have.
# More powerful workers will be created if you have more
CPU_CORES = 8

# Internal network prefix for the VM network
# See the documentation before changing this
IP_NW = "192.168.56."

Vagrant.configure("2") do |config|
    config.vm.box = "debian/bookworm64"
    config.vm.boot_timeout = 900
    config.vm.box_check_update = true

    # Network
    config.vm.hostname =  PRJ_HOSTNAME
    # FIXME: Change bridge adapter name and IP address according to your environment
    # For exanple, I use eno1 and IP address 10.0.0.128/28
    config.vm.network "public_network",
      bridge: "eno1", ip: "10.0.0.131", hostname: true

    config.vm.network "forwarded_port", guest: 80, host: 8080,
      auto_correct: true
    config.vm.network "forwarded_port", guest: 443, host: 8443,
      auto_correct: true

    config.vm.synced_folder "../drupal8-website", PRJ_DIR

    # Config for hypervisor
    # config.vm.provider "hyperv" do |hv|
    # and change all vb. to hv.
    config.vm.provider "virtualbox" do |vb|
      vb.name = PRJ_NAME

      vb.memory = "2048"
      vb.cpus = "2"

      vb.gui = false
      vb.customize ["modifyvm", :id, "--audio", "none"]
    end

    config.vm.provision "file",
      source: "~/.ssh/id_ed25519.pub", destination: "~/.ssh/me.pub"

    config.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y openssh-server
      cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
      cat /home/vagrant/.ssh/me.pub >> /root/.ssh/authorized_keys
    SHELL

  end
