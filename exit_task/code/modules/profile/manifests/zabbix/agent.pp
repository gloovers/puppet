class profile::zabbix::agent {
  class {'zabbix_repo':
    baseurl    => lookup('profile::zabbix::server:baseurl'),
    baseurlnsp => lookup('profile::zabbix::server:baseurlnsp'),
    gpgkey     => lookup('profile::zabbix::server:gpgkey'),
    gpgkeynsp  => lookup('profile::zabbix::server:gpgkeynsp'),
  }

  class {'zabbix_agent':
   zabbix_server => lookup('profile::zabbix::agent:zabbix_server'),
  } 
}
