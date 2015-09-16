#require 'puppet/parser/functions'

Puppet::Parser::Functions.newfunction(:get_pem_location,
                                      :type => :rvalue,
                                      :doc => <<-EOD
Retreive the location of a pem file installed with a install_as_pem directive
    EOD
) do |args|
  name = args[0]
  
  raise(ArgumentError, 'Must specify a certificate') unless name
    
  return function_get_certificate_value( ["pem", name, "target"] ) 
end
