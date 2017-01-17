class nginxphp(
  $server_name = 'localhost',
  $doc_root = '/vagrant',
  $php_packages = ['php7.0-curl', 'php7.0-cli']
) {

  package { ['nginx', 'php7.0-fpm']:
    ensure  => 'installed'
  }

  service { 'nginx':
    ensure     => running,
    enable     => true,
  }

  service { 'php7.0-fpm':
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