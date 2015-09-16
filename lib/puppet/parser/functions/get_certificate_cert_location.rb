Puppet::Parser::Functions.newfunction(:get_certificate_cert_location,
                                      :type => :rvalue,
                                      :doc => <<-EOD
Retreive the location of the cert file of a certificate previously installed with a install_as_files directive
    EOD
) do |args|
  name = args[0]

  raise(ArgumentError, 'Must specify a certificate') unless name

  dir = function_get_certificate_value( ["files", name, "target_dir"] )
  cert = function_get_certificate_value( ["files", name, "cert_file_name"] )

  if dir.empty?
    raise(ArgumentError, "No certificate '#{name}' found")
  end

  if cert.empty? # default param value
    cert = "#{name}.crt"
  end

  return "#{dir}/#{cert}"
end
