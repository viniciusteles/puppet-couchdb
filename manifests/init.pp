class couchdb(
  $ip='UNSET', 
  $port='UNSET',
  $require_valid_user='UNSET',
  $admin_password='UNSET',
) {
  # Module compatibility checks
  #
  if ! ($::operatingsystem in ['Debian', 'Ubuntu']) {
    fail("Module ${module_name} does not support ${::operatingsystem}")
  }

  if ! ($::lsbdistcodename in ['lenny', 'squeeze', 'maverick', 'natty', 'precise']) {
    fail("Module ${module_name} does not support ${::lsbdistcodename}")
  }

  # Parameters setting
  #
  if ($ip == 'UNSET') {
    $ip_param = '127.0.0.1'
  } else {
    $ip_param = $ip
  }

  if ($port == 'UNSET') {
    $port_param = '5984'
  } else {
    $port_param = $port
  }

  if ($require_valid_user == 'UNSET') {
    $require_valid_user_line = "; require_valid_user = false"
  } else {
    $require_valid_user_line = "require_valid_user = ${require_valid_user}"
  }

  if ($admin_password == 'UNSET') {
    $admin_password_line = "; admin = mysecretpassword"
  } else {
    $admin_password_line = "admin = ${admin_password}"
  }

  file { '/etc/couchdb/local.ini':
    ensure  => present,
    content => template('couchdb/local.ini.erb'),
    owner   => 'couchdb',
    group   => 'couchdb',
    mode    => 664,
    require => Package['couchdb'],
    notify  => Service['couchdb'],
  } 
  
  package { 'couchdb':
    ensure  => present,
  }

  service { "couchdb":
    ensure     => running,
    enable     => true,
    hasstatus  => false,
    hasrestart => false,
    require    => Package['couchdb'],
  }
}
