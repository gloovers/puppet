class profile::mysql::server {
  class { '::mysql::server':
    root_password           => 'root',
    remove_default_accounts => true,
  } 
}
