$prep_script = <<EOF
if [ ! -f ~/runonce ]; then
  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confnew' upgrade
  apt-get install python -y
  touch ~/runonce
fi
EOF


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
    vb.gui = false
  end

  nodes = 3
  nodes_a = []
  (1..nodes).each { |n| nodes_a << "node-#{n}" }
  (1..nodes).each do |machine_id|
    config.vm.define "node-#{machine_id}" do |machine|
      machine.vm.hostname = "node-#{machine_id}"
      machine.vm.network "private_network", ip: "198.18.0.#{20+machine_id}"

      machine.vm.provision :shell,
        privileged:true,
        inline:$prep_script

      if machine_id == nodes
        machine.vm.provision :ansible do |ansible|
          ansible.limit = "all"
          ansible.playbook = "playbooks/vagrant_play.yml"
          ansible.groups = {
            "beegfs-mgmtd" => ["node-1"],
            "beegfs-nodes" => nodes_a,
            "beegfs-meta" => nodes_a,
            "beegfs-storage" => nodes_a,
            "beegfs-utils" => nodes_a,
            "beegfs-client" => nodes_a
          }
        end
      end
    end
  end
end
