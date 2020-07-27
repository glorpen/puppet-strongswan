define strongswan::conf::swanctl (
  Hash $config = {}
){
  file { "${::strongswan::swanctl_config_dir}/${title}.conf":
    ensure  => present,
    content => strongswan::to_config($config)
  }
}
