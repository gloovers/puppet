class zabbix_server(
  $baseurl,
  $baseurlnsp,
  $gpgkey,
  $gpgkeynsp,
) {
  package { 'zabbix-server-mysql':
    ensure   => present,
  }
  
  package { 'zabbix-web-mysql':
    ensure   => present,
  }
  
  package { 'zabbix-agent':
    ensure   => present,
  }

  class { 'zabbix_server::start':   
    baseurl    => $baseurl,
    baseurlnsp => $baseurlnsp,
    gpgkey     => $gpgkey,
    gpgkeynsp  => $gpgkeynsp,
  }
}
