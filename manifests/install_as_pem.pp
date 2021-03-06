define certificate::install_as_pem (
  $ensure           = 'present',
  $certificate_name = "${name}",
  $target_dir,
  $pem_file_name    = "${name}.pem",
  $owner            = $certificate::params::default_owner,
  $group            = $certificate::params::default_group,
  $mode             = $certificate::params::default_mode,
) {
  if ! defined( Certificate::Declare["${certificate_name}"] ) {
    fail("Certificate ${certificate_name} is not defined.")
  }

  $key_file   = getparam(Certificate::Declare["${certificate_name}"], "key_file")
  $cert_file  = getparam(Certificate::Declare["${certificate_name}"], "cert_file")
  $chain_file = getparam(Certificate::Declare["${certificate_name}"], "chain_file")

  concat { "${name}" :
    ensure          => "${ensure}",
    path            => "${target_dir}/${pem_file_name}",
    owner           => "${owner}",
    group           => "${group}",
    ensure_newline  => true,
    mode            => $mode,
  }

  concat::fragment { "${name}_cert" :
    target  => "${name}",
    order   => 10,
    source  => "${cert_file}",
  }

  concat::fragment { "${name}_key" :
    target  => "${name}",
    order   => 20,
    source  => "${key_file}",
  }

  if $chain_file != undef {
    concat::fragment { "${name}_chain" :
      target  => "${name}",
      order   => 30,
      source  => "${chain_file}",
    }
  }

}
