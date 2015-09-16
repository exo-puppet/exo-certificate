Puppet::Parser::Functions.newfunction(:get_certificate_key_location,
                                      :type => :rvalue,
                                      :doc => <<-EOD
Retreive the location of the key file of a certificate previously installed with a install_as_files directive
    EOD
) do |args|
  name = args[0]

  raise(ArgumentError, 'Must specify a certificate') unless name

  dir = function_get_certificate_value( ["files", name, "target_dir"] )
  key = function_get_certificate_value( ["files", name, "key_file_name"] )

  if dir.empty?
    raise(ArgumentError, "No certificate '#{name}' found")
  end

  if key.empty? # default param value
    key = "#{name}.key"
  end

  return "#{dir}/#{key}"
end
