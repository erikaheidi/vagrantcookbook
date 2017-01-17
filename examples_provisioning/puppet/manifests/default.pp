Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

$system_packages = ['vim', 'curl', 'git']
$php_packages = ['php7.0-cli', 'php7.0-curl']

# first thing must be apt-get update
exec { 'apt-get update':
  command => 'apt-get update'
}

package { 'python-software-properties':
  ensure  => "installed",
  require => Exec['apt-get update']
}

exec { 'add-repository':
  command => "add-apt-repository ppa:ondrej/php -y",
  require => Package['python-software-properties'],
}

package { $system_packages:
  ensure => "installed",
  require => Exec['apt-get update'],
}

exec { 'apt-update-refresh':
  command => 'apt-get update',
  require => Exec['add-repository'],
  before  => Class['nginxphp']
}

class { 'nginxphp':
  server_name => $ipaddress_eth1,
  doc_root => '/vagrant/web',
  php_packages => $php_packages,
}