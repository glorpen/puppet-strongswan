class strongswan::config {
  file {
    [
      $::strongswan::config_dir,
      $::strongswan::swan_config_dir,
      $::strongswan::charon_plugin_config_dir,
      $::strongswan::swanctl_dir,
      $::strongswan::swanctl_config_dir
    ]:
    ensure  => 'directory',
    purge   => true,
    recurse => true,
    force   => true
  }

  $swan_config = {
    'charon' => {
      'load_modular' => 'yes',
      'plugins' => {
        'include' => "${::strongswan::charon_plugin_config_dir}/*.conf"
      }
    },
    'include' => "${::strongswan::swan_config_dir}/*.conf"
  }

  $swanctl_config = {
    'include' => "${::strongswan::swanctl_config_dir}/*.conf"
  }

  file { $::strongswan::strongswan_config:
    ensure  => present,
    content => strongswan::to_config($swan_config)
  }

  file { $::strongswan::swanctl_config:
    ensure  => present,
    content => strongswan::to_config($swanctl_config)
  }
}
