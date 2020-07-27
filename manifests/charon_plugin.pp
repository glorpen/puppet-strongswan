define strongswan::charon_plugin(
  Hash $options = {}
){
  $config_dir = $::strongswan::charon_plugin_config_dir
  $defaults = {
    $name => {
      'load' => 'yes',
    }
  }

  file { "${config_dir}/${title}.conf":
    content => strongswan::to_config({$name => merge($defaults, $options)})
  }
}
