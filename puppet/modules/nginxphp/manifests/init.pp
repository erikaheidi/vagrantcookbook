# Class: nginxphp
#
# Main nginxphp manifest
#

class nginxphp(
  $doc_root = '/vagrant',
  $php_packages = ['php5-curl', 'php5-cli', 'php-pear', 'php5-mysql']
) {

  package { ['nginx', 'php5-fpm']:
    ensure  => 'installed'
  }

  service { 'nginx':
    ensure     => running,
    enable     => true,
  }

  service { 'php5-fpm':
    ensure     => running,
    enable     => true,
  }

  file { "/etc/nginx/sites-available/default":
    ensure  => 'present',
    content => template("nginxphp/nginx/vhost.erb"),
    require => Package['nginx'],
  }

  package { $php_packages:
    ensure => "installed"
  }

}