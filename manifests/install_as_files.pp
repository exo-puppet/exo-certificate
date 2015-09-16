define certificate::install_as_files (
  $ensure           = 'present',
  $certificate_name,
  $target_dir,
  $cert_file_name   = "${name}.crt",
  $key_file_name    = "${name}.key",
  $chain_file_name  = "${name}.chain",
  $owner            = $certificate::params::default_owner,
  $group            = $certificate::params::default_group,
  $mode             = $certificate::params::default_mode,
  $notify           = undef,
  $require          = undef,
) {
  include certificate::params

  if ! defined( Certificate::Declare["${certificate_name}"] ) {
    fail("Certificate ${certificate_name} is not defined.")
  }

  $key_file   = getparam(Certificate::Declare["${certificate_name}"], "key_file")
  $cert_file  = getparam(Certificate::Declare["${certificate_name}"], "cert_file")
  $chain_file = getparam(Certificate::Declare["${certificate_name}"], "chain_file")

  file { "${target_dir}/${cert_file_name}" :
    ensure    => "${ensure}",
    source    => "${cert_file}",
    owner     => "${owner}",
    group     => "${group}",
    mode      => "${mode}",
    notify    => $notify,
    require   => $require,
  }

  file { "${target_dir}/${key_file_name}" :
    ensure    => "${ensure}",
    source    => "${key_file}",
    owner     => "${owner}",
    group     => "${group}",
    mode      => "${mode}",
    notify    => $notify,
    require   => $require,
  }

  if $chain_file != undef {
    file { "${target_dir}/${chain_file_name}" :
      ensure    => "${ensure}",
      source    => "${chain_file}",
      owner     => "${owner}",
      group     => "${group}",
      mode      => "${mode}",
      notify    => $notify,
      require   => $require,
    }
  }
}
