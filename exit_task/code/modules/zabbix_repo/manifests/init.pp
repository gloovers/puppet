class zabbix_repo(
#  $baseurl    = "http://repo.zabbix.com/zabbix/3.2/rhel/7/\$basearch/",
#  $baseurlnsp = "http://repo.zabbix.com/non-supported/rhel/7/\$basearch/",
#  $gpgkey     = "https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-A14FE591",
#  $gpgkeynsp  = "https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX",
  $baseurl,
  $baseurlnsp,
  $gpgkey,
  $gpgkeynsp,

) {
  $zabbix_repo_hash = {
    'baseurl'    => $baseurl,
    'baseurlnsp' => $baseurlnsp,
    'gpgkey'     => $gpgkey,
    'gpgkeynsp'     => $gpgkeynsp,
  }
  file { "/etc/yum.repos.d/zabbix.repo":
    content => epp('zabbix_repo/zabbix.repo.epp', $zabbix_repo_hash), 
  }

}

