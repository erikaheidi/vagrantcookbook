################################################
# sandbox-php Chef provisioning: nginxphp
# @author Erika Heidi <erika@erikaheidi.com>
################################################

# nginx and php5-fpm
["nginx", "php5-fpm"].each do |p|

 apt_package p do
     action :install
 end

end

# php packages
node['php']['packages'].each do |p|

 apt_package p do
     action :install
 end

end

service "nginx" do
    action [ :enable, :start ]
end

service "php5-fpm" do
    action [ :enable, :start ]
end

# set nginx default site
template "/etc/nginx/sites-available/default" do
    source "vhost.erb"
    variables({
        :doc_root    => node['nginx']['doc_root'],
        :server_name => node['nginx']['server_name']
    })
    action :create
    notifies :restart, resources(:service => "nginx")
end

