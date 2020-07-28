define strongswan::conf::swanctl (
  Hash $config = {}
){
  $file = file { "${::strongswan::swanctl_config_dir}/${title}.conf":
    ensure  => present,
    content => strongswan::to_config($config)
  }

  if $::strongswan::manage_service {
    $file~>Class['strongswan::service']
  }
}
