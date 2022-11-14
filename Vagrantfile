MACHINES = {
    :server => {
        :box_name => "generic/centos7",
#        :box_version => "2004.01",
        :ip_addr => '192.168.1.2',
        :script => './server.sh',
        :hostwebport => '80'
    },
    :client => {
        :box_name => "generic/centos7",
#        :box_version => "2004.01",
        :ip_addr => '192.168.1.3',
        :script => './server.sh',
        :hostwebport => '81'
    },
}
 

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.define boxname do |box|
        config.vm.box = boxconfig[:box_name]
#        box.vm.box_version = boxconfig[:box_version]
        box.vm.host_name = boxname.to_s
        box.vm.network :forwarded_port, guest: 80, host: boxconfig[:hostwebport]
        box.vm.network "private_network", ip: boxconfig[:ip_addr], netmask: "255.255.255.0", virtualbox__intnet: "nfs_fuse_net"
        box.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "512"]
        end
        box.vm.provision "shell", inline: <<-SHELL
          echo -en "192.168.1.2 server\n192.168.1.3 client\n\n" | sudo tee -a /etc/hosts
          SHELL
        box.vm.provision "shell", path: boxconfig[:script]
    end
  end
end
