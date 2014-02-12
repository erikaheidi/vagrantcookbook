class nginxphp(
  $server_name = 'localhost',
  $doc_root = '/vagrant',
  $php_packages = ['php5-curl', 'php5-cli']
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
    content => template("nginxphp/vhost.erb"),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  package { $php_packages:
    ensure => "installed"
  }

}