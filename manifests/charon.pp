class strongswan::charon {
  include ::stdlib

  $default_plugins = [
    'acert', 'aes', 'aesni', 'attr',
    'ccm', 'chapoly', 'cmac', 'constraints', 'counters', 'ctr', 'curl', 'curve25519',
    'des', 'dhcp', 'dnskey', 'drbg', 'duplicheck',
    'eap-aka-3gpp', 'eap-aka-3gpp2', 'eap-aka', 'eap-dynamic', 'eap-gtc', 'eap-identity',
    'eap-md5', 'eap-mschapv2', 'eap-peap', 'eap-radius', 'eap-tls',
    'eap-tnc', 'eap-ttls',
    'farp', 'fips-prf',
    'gcm', 'gcrypt', 'gmp',
    'ha', 'hmac',
    'ipseckey',
    'kernel-libipsec', 'kernel-netlink',
    'led',
    'md4', 'md5', 'mgf1',
    'newhope', 'nonce', 'openssl',
    'pem', 'pgp', 'pkcs1', 'pkcs11', 'pkcs12', 'pkcs7', 'pkcs8', 'pubkey',
    'random', 'rc2', 'resolve', 'revocation',
    'sha1', 'sha2', 'socket-default', 'sql', 'sqlite', 'sshkey',
    'tnc-ifmap', 'tnc-imc', 'tnc-imv', 'tnc-pdp', 'tnc-tnccs', 'tnccs-11', 'tnccs-20',
    'tnccs-dynamic', 'tpm',
    'unity', 'updown',
    'vici',
    'x509', 'xauth-eap', 'xauth-generic', 'xauth-noauth', 'xauth-pam', 'xcbc'
  ]

  difference($default_plugins, $::strongswan::charon_skip_default_plugins).each | $n | {
    strongswan::conf::charon { $n: }
  }
}
