################################################
# sandbox-php Chef provisioning: entry point
# @author Erika Heidi <erika@erikaheidi.com>
################################################

#system packages
node.default['system']['packages'] = ['curl','git','vim']

#nginx settings
node.default['nginx']['server_name'] = "192.168.33.101"
node.default['nginx']['doc_root'] = "/vagrant/web"

#php packages
node.default['php']['packages'] = ['php5-cli','php5-curl']

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
