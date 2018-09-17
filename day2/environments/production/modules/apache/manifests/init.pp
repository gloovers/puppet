class apache {

  if $::osfamily == 'RedHat' {
    $apache_name = 'httpd'
    $site_path = '/var/www/html'
    $config_path = '/etc/httpd/conf.d/site.conf'
  } elsif $::osfamily == 'Debian' {
    $apache_name = 'apache2'
    $site_path = '/var/www/html'
    $config_path = '/etc/apache2/sites-enabled/site.conf'
  }

  package { $apache_name:
    ensure   => installed,
  }
  
  service { $apache_name:
    ensure => running,
    require => Package[$apache_name],
  }
  
  $site_path_hash = {
    'site_path' => $site_path,
  }
  file { $config_path:
    content => epp('apache/site.conf.epp', $site_path_hash),
    notify  => Service[$apache_name],
  }

}


