class common {

  package { 'net-tools':
    ensure => installed,
  }
  
  package { 'vim-enhanced':
    ensure => installed,
  }
  
}
