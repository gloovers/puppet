class profile::zabbix::server {
  class {'zabbix_repo':
    baseurl    => lookup('profile::zabbix::server:baseurl'),
    baseurlnsp => lookup('profile::zabbix::server:baseurlnsp'),
    gpgkey     => lookup('profile::zabbix::server:gpgkey'),
    gpgkeynsp  => lookup('profile::zabbix::server:gpgkeynsp'),
  }
  class {'zabbix_server':
    dbname => lookup('profile::zabbix::server:dbname'),
    dbhost => lookup('profile::zabbix::server:dbhost'),
    dbuser => lookup('profile::zabbix::server:dbuser'),
    dbpass => lookup('profile::zabbix::server:dbpass'),
  }
  mysql::db { lookup('profile::zabbix::server:dbname'):
    user     => lookup('profile::zabbix::server:dbuser'),
    password => lookup('profile::zabbix::server:dbpass'),
    host     => lookup('profile::zabbix::server:dbhost'),
    grant    => ['ALL'],
    sql      => '/usr/share/doc/zabbix-server-mysql-*/create.sql.gz',
    import_cat_cmd => 'zcat',
    import_timeout => 900,
  }
  
}
