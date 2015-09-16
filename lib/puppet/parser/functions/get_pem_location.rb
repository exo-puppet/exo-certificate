#require 'puppet/parser/functions'

Puppet::Parser::Functions.newfunction(:get_pem_location,
                                      :type => :rvalue,
                                      :doc => <<-EOD
Retreive the location of a pem file installed with a install_as_pem directive
    EOD
) do |args|
  name = args[0]
  
  raise(ArgumentError, 'Must specify a certificate') unless name
    
  dir = function_get_certificate_value( ["pem", name, "target_dir"] )
  pem = function_get_certificate_value( ["pem", name, "pem_file_name"] )

  if dir.empty?
    raise(ArgumentError, "No certificate '#{name}' found")
  end

  if pem.empty? # default param value
    pem = "#{name}.pem"
  end

  return "#{dir}/#{pem}"
end
