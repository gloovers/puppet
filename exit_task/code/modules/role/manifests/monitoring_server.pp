class role::monitoring_server {
  include profile::common::pkgs
  include profile::mysql::server
  include profile::zabbix::server
}
