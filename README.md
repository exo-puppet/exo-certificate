# Certificate puppet module

This is a puppet module to manage ssl certificates and their installation.

## Usage

### Declare a new certificate

```
  certificate::declare { "my_cert" :
    cert_file  => "puppet:///my_location/certificate.crt",
    key_file   => "puppet:///my_location/certificate.key",
    chain_file => "puppet:///my_location/certificate.chain", # Optional
  }
```

This is just a declarative class, this is not installing anything.

### Use a declared certificate

#### As a pem
To generate a pem file, the cert file, the key file and the chain file will be
concatenated into one file in this order.

Minimal usage :
```
certificate::install_as_pem { "my_cert" :
    certificate_name => "my_cert",
    target_dir  => "/location"
  }
```
Where :
* **certificate** : the name of a certificate::declare definition
* **target_dir** : the target directory where the certificate will be generated

You can also provide optional parameters :
* **pem_file_name** : the name of the generated file, default *${name}.pem*
* **ensure**  : *present* or *absent*, default *present*
* **owner**   : The owner of the file, default *root*
* **group**   : The group of the file, default *root*
* **mode**    : The permissions applied to the file, default *644*
* **notify**  : Any class to notify on update, none by default, example:  ` notify => Class['apache']]`
* **require** : Add a dependency on this definition, none by default, example : `require => [File["/location"]]`

#### As separate files
The 3 files will be installed as this.

Minimal usage :
```
  certificate::install_as_files { "my_cert" :
    certificate_name => "my_cert",
    target_dir => "/location",
  }
```
Where :
* **certificate** : the name of a certificate::declare definition
* **target_dir** : the target directory where the certificate files will be copied

You can also provide optional parameters :
* **ensure**          : *present* or *absent*, default *present*
* **cert_file_name**  : The certificate file name, default *${name}.crt*
* **key_file_name**   : The certificat key file name, default *${name}.key*
* **chain_file_name** : The CA chain file name, default *${name}.chain*
* **owner**           : The owner of the files, default *root*
* **group**           : The group of the files, default *root* 
* **mode**            : The permission applied to the files, default *644*
* **notify**          : Any class to notify on update, none by default, example:  ` notify => Class['apache']]`
* **require**         : Add a dependency on this definition, none by default, example : `require => [File["/location"]]`

### Reference an installed certificate

Certificate module add some utility functions to simplify the certificate usage.
For pem certificates :
* **get_pem_location** : return the pem file location on the filesystem
For certificates installed with separate files :
* **get_certificate_cert_location**  : return the crt file location
* **get_certificate_key_location**   : return the key file location
* **get_certificate_chain_location** : return the CA chain file location

## Full example

```
  certificate::declare { "my_cert" :
    cert_file  => "puppet:///my_location/certificate.crt",
    key_file   => "puppet:///my_location/certificate.key",
    chain_file => "puppet:///my_location/certificate.chain", # Optional
  }
  certificate::install_as_pem { "my_cert" :
    certificate_name => "my_cert",
    target_dir => "/location",
  }
  
  $my_pem_file = get_pem_location("my_cert")
```
Or in some template :
```
    PemFile=<%= scope_function_get_pem_location(["my_cert"]) %>
```

## License

Copyright (C) 2015 eXo Platform SAS.

This is free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 3 of
the License, or (at your option) any later version.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this software; if not, write to the Free
Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
02110-1301 USA, or see the FSF site: <http://www.fsf.org>.

## Contact

eXo platform - Software Factory Team 
mailto : <exo-swf@exoplatform.com>

## Support

Please log tickets and issues at our [Projects site](https://github.com/exo-puppet/exo-certificate)
