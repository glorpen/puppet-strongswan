class strongswan(
  String $package_name = 'strongswan',
  Boolean $manage_package = true,
  Stdlib::AbsolutePath $config_dir = '/etc/strongswan',
  String $service_name = 'strongswan-swanctl',
  Boolean $manage_service = true,
  Array[String] $charon_skip_default_plugins = []
) {

  $charon_plugin_config_dir = "${config_dir}/charon"
  $swan_config_dir = "${config_dir}/conf.d"
  $swan_config = "${config_dir}/strongswan.conf"

  $swanctl_dir = "${config_dir}/swanctl"
  $swanctl_config_dir = "${swanctl_dir}/conf.d"
  $swanctl_config = "${swanctl_dir}/swanctl.conf"

  include ::strongswan::config
  include ::strongswan::charon

  Class['strongswan::config']
  ->Class['strongswan::charon']

  if $manage_package {
    include ::strongswan::package

    Class['strongswan::package']
    ~>Class['strongswan::config']
  }

  if $manage_service {
    include ::strongswan::service

    Class['strongswan::config']
    ~>Class['strongswan::service']

    Strongswan::Conf::Charon <| |>
    ~>Class['strongswan::service']

    Strongswan::Conf::Swanctl <| |>
    ~>Class['strongswan::service']

    Strongswan::Conf::Swan <| |>
    ~>Class['strongswan::service']
  }

}
