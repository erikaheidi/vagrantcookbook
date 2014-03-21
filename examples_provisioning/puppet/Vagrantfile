Vagrant.configure("2") do |config|

    config.vm.box = "hashicorp/precise64"

    config.vm.network :private_network, ip: "192.168.33.101"

    config.vm.provision :puppet do |puppet|
        puppet.module_path = "modules"
    end

    config.vm.synced_folder "../../testapp", "/vagrant", :nfs => true

end