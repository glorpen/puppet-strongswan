define strongswan::conf::charon(
  Hash $options = {}
){
  $config_dir = $::strongswan::charon_plugin_config_dir
  $defaults = {
    'load' => 'yes',
  }

  $file = file { "${config_dir}/${title}.conf":
    content => strongswan::to_config({$name => merge($defaults, $options)})
  }

  if $::strongswan::manage_service {
    $file~>Class['strongswan::service']
  }
}
