class zabbix_agent (
  $zabbix_server = '',
  $api_user      = 'Admin',
  $api_pass      = 'zabbix',  
) {

  package { 'zabbix-agent':
    ensure   => present,
  }

  $api_connect_hash = {
    'zabbix_server' => $zabbix_server,
    'api_user' => $api_user,
    'api_pass' => $api_pass,
  }
  
  $zabbix_server_hash = {
    'zabbix_server' => $zabbix_server,
  }
  
  file { "/etc/zabbix/zabbix_agentd.conf":
    content => epp('zabbix_agent/zabbix_agentd.conf.epp', $zabbix_server_hash),
    notify  => Service['zabbix-agent'],
  }

  service { 'zabbix-agent':
    ensure  => running,
    require => Package['zabbix-agent'],
  }
 
  file { "/tmp/reg_agent.sh":
    content => epp('zabbix_agent/reg_agent.sh.epp', $api_connect_hash),
    require => Service['zabbix-agent'],
    ensure  => 'present',
    mode    => '0755',
  }

  exec { 'agent reg':
    command => "/tmp/reg_agent.sh",
    require => File['/tmp/reg_agent.sh'],
    path    => '/sbin:/bin:/usr/sbin:/usr/bin',
  }

}
