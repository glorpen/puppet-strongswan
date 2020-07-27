class strongswan(
  $package_name = 'strongswan',
  $config_dir = '/etc/strongswan',
  $service_name = 'strongswan'
) {

  $charon_plugin_config_dir = "${config_dir}/charon"
  $swan_config_dir = "${config_dir}/conf.d"
  $swan_config = "${config_dir}/strongswan.conf"

  $swanctl_dir = "${config_dir}/swanctl"
  $swanctl_config_dir = "${swanctl_dir}/conf.d"
  $swanctl_config = "${swanctl_dir}/swanctl.conf"

  Class['strongswan::package']
  ~>Class['strongswan::config']
  ~>Class['strongswan::service']

  Strongswan::Charon_plugin <| |>
  ~>Class['strongswan::service']
}
