# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define Vagrant box to use
BOX_OS = "ubuntu/jammy64"

# Define how much memory your computer has in GB (e.g. 8, 16)
# Larger nodes will be created if you have more.
RAM_SIZE = 8

# Define how mnay CPU cores you have.
# More powerful workers will be created if you have more
CPU_CORES = 4

# Define the number of master and worker nodes. You should not change this
NUM_CONTROL_NODES = 2
NUM_WORKER_NODE = 2

# Internal network prefix for the VM network
# See the documentation before changing this
IP_NW = "192.168.56."

# Host address start points
MASTER_IP_START = 10
NODE_IP_START = 20
LB_IP_START = 30

# Calculate resource amounts
# based on RAM/CPU
ram_selector = (RAM_SIZE / 4) * 4
if ram_selector < 8
  raise "Unsufficient memory #{RAM_SIZE}GB. min 8GB"
end
RESOURCES = {
  "control" => {
    1 => {
      # controlplane01 bigger since it may run e2e tests.
      "ram" => [ram_selector * 128, 2048].max(),
      "cpu" => CPU_CORES >= 12 ? 4 : 2,
    },
    2 => {
      # All additional masters get this
      "ram" => [ram_selector * 128, 2048].min(),
      "cpu" => CPU_CORES > 8 ? 2 : 1,
    },
  },
  "worker" => {
    "ram" => [ram_selector * 128, 4096].min(),
    "cpu" => CPU_CORES > 8 ? 2 : 1,
  },
}

# Runs provisioning steps that are required by masters and workers
def provision_kubernetes_node(node)
  # Set up ssh
  node.vm.provision "setup-ssh", :type => "shell", :path => "vm/utils/ssh.sh"

  # Set up with Ansible
  node.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    # ansible.verbose = "v"
    ansible.playbook = "ansible/provision.yml"
  end
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "base"
  config.vm.box = BOX_OS
  config.vm.boot_timeout = 900

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Provision Control Nodes
  (1..NUM_CONTROL_NODES).each do |i|
    config.vm.define "controlplane0#{i}" do |node|
      # Name shown in the GUI
      node.vm.provider "virtualbox" do |vb|
        vb.name = "kubernetes-ha-controlplane-#{i}"
        vb.memory = RESOURCES["control"][i > 2 ? 2 : i]["ram"]
        vb.cpus = RESOURCES["control"][i > 2 ? 2 : i]["cpu"]
        # Disable gui & audio for headless operation in VirtualBox
        vb.gui = false
        vb.customize ["modifyvm", :id, "--audio", "none"]
      end
      node.vm.hostname = "controlplane0#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_START + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2710 + i}"
      # Provision the node
      provision_kubernetes_node node
      if i == 1
        # Add cetificate verification scripts
        node.vm.provision "file", source: "vm/utils/cert_verify.sh", destination: "$HOME/certs/cert_verify.sh"
        node.vm.provision "file", source: "vm/utils/approve_csr.sh", destination: "$HOME/certs/approve_csr.sh"
      end
    end
  end

  # Provision Load Balancer Node
  config.vm.define "loadbalancer" do |node|
    node.vm.provider "virtualbox" do |vb|
      vb.name = "kubernetes-ha-lb"
      vb.memory = 512
      vb.cpus = 1
      # Disable gui & audio for headless operation in VirtualBox
      vb.gui = false
      vb.customize ["modifyvm", :id, "--audio", "none"]
    end
    node.vm.hostname = "loadbalancer"
    node.vm.network :private_network, ip: IP_NW + "#{LB_IP_START}"
    node.vm.network "forwarded_port", guest: 22, host: 2730
    # Provision the node
    provision_kubernetes_node node
  end

  # Provision Worker Nodes
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "node0#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "kubernetes-ha-node-#{i}"
        vb.memory = RESOURCES["worker"]["ram"]
        vb.cpus = RESOURCES["worker"]["cpu"]
        vb.gui = false
        vb.customize ["modifyvm", :id, "--audio", "none"]
      end
      node.vm.hostname = "node0#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"
      # Provision the node
      provision_kubernetes_node node
    end
  end
end
