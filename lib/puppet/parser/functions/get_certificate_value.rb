
Puppet::Parser::Functions.newfunction(:get_certificate_value,
                                      :type => :rvalue) do |args|
  type = args[0]
  name = args[1]
  param = args[2]
  
  raise(ArgumentError, 'Must specify a type <pem> or <files>') unless type and (type == "pem" or type == "files")
  raise(ArgumentError, 'Must specify a name') unless name
  raise(ArgumentError, 'Must specify a param name') unless param

  clazz = "Certificate::Install_as_#{type}[#{name}]"

  #if ! function_defined( [clazz] )
  #  raise(ArgumentError, "No certificate found for #{clazz}")
  #end

  return function_getparam( [clazz, param] );
end
