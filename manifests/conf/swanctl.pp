define strongswan::conf::swantctl (
  Hash $config = {}
){
  file { "${::strongswan::swanctl_config_dir}/${title}.conf":
    ensure  => present,
    content => strongswan::to_config($config)
  }
}
