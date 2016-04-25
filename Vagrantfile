# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'puppetlabs/debian-6.0.10-64-nocm'

  N=2
  (1..N).each do |node_id|
    config.vm.define "node#{node_id}" do |node|
      node.vm.network "private_network", ip: "192.168.56.#{100+node_id}"
      setupVirtualBox(node, "node#{node_id}")
      if node_id == N
        node.vm.provision ":install", type: "ansible" do |ansible|
          ansible.inventory_path = "./hosts"
          ansible.limit = "all"
          ansible.playbook = "main.yml"
        end
      end
    end
  end
end

def setupVirtualBox(config, name)
  config.vm.provider "virtualbox" do |v|
    v.cpus = 1
    v.gui = false
    v.memory = 2048
    v.name = name
    v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    v.customize ["modifyvm", :id, "--vram", "16"]
    v.customize ["modifyvm", :id, "--paravirtprovider", "kvm"]
    v.customize ["storagectl", :id, "--name", "IDE Controller", "--hostiocache", "off"]
  end
end
