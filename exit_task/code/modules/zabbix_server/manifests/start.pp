class zabbix_server::start (
  $dbhost,
  $dbname,
  $dbuser,
  $dbpass,
){
  $db_connect_hash = {
    'dbhost' => $dbhost,
    'dbname' => $dbname,
    'dbuser' => $dbuser,
    'dbpass' => $dbpass,
  }
  file { "/etc/zabbix/zabbix_server.conf":
    content => epp('zabbix_server/zabbix_server.conf.epp', $db_connect_hash),
    notify  => Service['zabbix-server'],
  }
  
  exec { 'uncomment_time_zone':
    command => "sed -i '/date.timezone/ s/# //' /etc/httpd/conf.d/zabbix.conf",
    path      => '/sbin:/bin:/usr/sbin:/usr/bin',
  } 

  exec { 'change_time_zone':
    command => "sudo sed -i '/date.timezone/ s/Europe\/Riga/Europe\/Minsk/' /etc/httpd/conf.d/zabbix.conf",
    path      => '/sbin:/bin:/usr/sbin:/usr/bin',
    require => Exec['uncomment_time_zone'],
    notify  => Service['httpd'],
  }
  
  file { "/etc/zabbix/web/zabbix.conf.php":
    content => epp('zabbix_server/zabbix.conf.php.epp', $db_connect_hash),
  }  

  service { 'zabbix-server':
    ensure => running,
  }

  service { 'httpd':
    ensure => running,
  }

  service { 'zabbix-agent':
    ensure => running,
  }
}
