Puppet::Parser::Functions.newfunction(:get_certificate_chain_location,
                                      :type => :rvalue,
                                      :doc => <<-EOD
Retreive the location of the ca chain file of a certificate previously installed with a install_as_files directive
    EOD
) do |args|
  name = args[0]

  raise(ArgumentError, 'Must specify a certificate') unless name

  dir = function_get_certificate_value( ["files", name, "target_dir"] )
  chain = function_get_certificate_value( ["files", name, "chain_file_name"] )

  if chain.empty? # default param value
    chain = "#{name}.chain"
  end

  return "#{dir}/#{chain}"
end
