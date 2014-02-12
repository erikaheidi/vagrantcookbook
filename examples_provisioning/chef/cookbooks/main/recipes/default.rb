node.default['system']['packages'] = ['curl','git','vim']

node.default['nginx']['server_name'] = "192.168.33.101"
node.default['nginx']['doc_root'] = "/vagrant/web"

node.default['php']['packages'] = ['php5-curl','php5-cli']

execute "apt-get update" do
    command "apt-get update"
end

apt_package "python-software-properties" do
    action :install
end

execute "add-apt-repository" do
    command "add-apt-repository ppa:ondrej/php5"
end

execute "apt-get update" do
    command "apt-get update"
end

node['system']['packages'].each do |p|
    apt_package p do
        action :install
    end
end

include_recipe 'nginxphp'
