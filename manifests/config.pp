class strongswan::config {
  $private_dir = "${::strongswan::swanctl_dir}/private"
  $rsa_dir = "${::strongswan::swanctl_dir}/rsa"
  $ecdsa_dir = "${::strongswan::swanctl_dir}/ecdsa"
  $bliss_dir = "${::strongswan::swanctl_dir}/bliss"
  $pkcs8_dir = "${::strongswan::swanctl_dir}/pkcs8"
  $pkcs12_dir = "${::strongswan::swanctl_dir}/pkcs12"
  $x509_dir = "${::strongswan::swanctl_dir}/x509"
  $x509ca_dir = "${::strongswan::swanctl_dir}/x509ca"
  $x509ocsp_dir = "${::strongswan::swanctl_dir}/x509ocsp"
  $x509aa_dir = "${::strongswan::swanctl_dir}/x509aa"
  $x509ac_dir = "${::strongswan::swanctl_dir}/x509ac"
  $x509crl_dir = "${::strongswan::swanctl_dir}/x509crl"
  $pubkey_dir = "${::strongswan::swanctl_dir}/pubkey"

  file {
    [
      $::strongswan::config_dir,
      $::strongswan::swan_config_dir,
      $::strongswan::charon_plugin_config_dir,
      $::strongswan::swanctl_dir,
      $::strongswan::swanctl_config_dir,
      $private_dir,
      $rsa_dir,
      $ecdsa_dir,
      $bliss_dir,
      $pkcs8_dir,
      $pkcs12_dir,
      $x509_dir,
      $x509ca_dir,
      $x509ocsp_dir,
      $x509aa_dir,
      $x509ac_dir,
      $x509crl_dir,
      $pubkey_dir
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

  file { $::strongswan::swan_config:
    ensure  => present,
    content => strongswan::to_config($swan_config)
  }

  file { $::strongswan::swanctl_config:
    ensure  => present,
    content => strongswan::to_config($swanctl_config)
  }
}
