require 'sif'
require "xmlrpc/client"

class System < Sif::Loader

  config_file '.buzz'

  desc "Delete self", "Delete this system from Spacewalk"
  def delete
    server = XMLRPC::Client.new(@spacewalk_server, "/rpc/api", 80)
    puts "Delete this system from spacewalk"

    begin
      key = server.call("auth.login", @username, @password)
      puts "Using session key #{key}"
      out = server.call("channel.software.create", 
            key,
            channel_label,
            name,
            summary,
            archLabel,
            parent,
            checksum
            )
      puts out
    rescue XMLRPC::FaultException => e
      puts "Error:"
      puts e.faultCode
      puts e.faultString
    end
  end

end
