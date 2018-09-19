class role::monitoring_agent {
  include profile::common::pkgs
  include profile::zabbix::agent
}

