define strongswan::conf::swan (
  Hash $config = {}
){
  file { "${::strongswan::swan_config_dir}/${title}.conf":
    ensure  => present,
    content => strongswan::to_config($config)
  }
}
