# vi: set ft=ruby :

# Builds Puppet Master and multiple Puppet Agent Nodes using JSON config file
# Author: Gary A. Stafford

# read vm and chef configurations from JSON files
nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  nodes_config.each do |node|
    node_name   = node[0] # name of node
    node_values = node[1] # content of node

	
    config.vm.define node_name do |config|    
      # configures all forwarding ports in JSON array
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
          host:  port[':host'],
          guest: port[':guest'],
          id:    port[':id']
      end

	  config.vm.box = node_values[':box']
      config.vm.hostname = node_name
      config.vm.network :private_network, ip: node_values[':ip']

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node_values[':memory']]
        vb.customize ["modifyvm", :id, "--name", node_name]
      end
	
	  
	  if node_values[':box'].include? "win"
	    config.vm.hostname = node_values[':host']
		config.vm.provision :shell, :path => "provisioner.ps1"
		config.vm.network :forwarded_port, host: 33389, guest: 3389, id: "rdp", auto_correct: true
      else
        config.vm.provision :shell, :path => node_values[':bootstrap']
      end
      
    end
  end
end