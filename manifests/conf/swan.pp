define strongswan::conf::swan (
  Hash $config = {}
){
  $file = file { "${::strongswan::swan_config_dir}/${title}.conf":
    ensure  => present,
    content => strongswan::to_config($config)
  }

  if $::strongswan::manage_service {
    $file~>Class['strongswan::service']
  }
}
