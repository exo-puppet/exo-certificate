Puppet::Parser::Functions.newfunction(:get_certificate_pem_location,
                                      :type => :rvalue,
                                      :doc => <<-EOD
Retreive the location of the pem file of a certificate previously installed with a install_as_files directive
    EOD
) do |args|
  name = args[0]

  raise(ArgumentError, 'Must specify a certificate') unless name

  dir = function_get_certificate_value( ["files", name, "target_dir"] )
  pem = function_get_certificate_value( ["files", name, "pem_file_name"] )

  if dir.empty?
    raise(ArgumentError, "No certificate '#{name}' found")
  end

  if pem.empty? # default param value
    pem = "#{name}.pem"
  end

  return "#{dir}/#{pem}"
end
