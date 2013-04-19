require 'sif'
require 'rexml/document'
require 'rexml/xpath'
require "xmlrpc/client"

class System < Sif::Loader

  config_file '.buzz'

  desc "Delete self", "Delete this system from Spacewalk"
  def deleteself
    server = XMLRPC::Client.new(@spacewalk_server, "/rpc/api", 80)
    systemid_file_path = '/etc/sysconfig/rhn/systemid'
    systemid_file_path = './systemid.xml'
    if (!File.exists?(systemid_file_path))
      puts "Cannot find system ID file - exiting"
      exit -1
    end
    systemid_file = File.read systemid_file_path 
    doc = REXML::Document.new(systemid_file)
    systemid = REXML::XPath.first( doc, 'string(//member[* = "system_id"]/value/string)' ).split('-')[1] 
    puts "Delete this system from spacewalk - ID #{systemid}"

    begin
      key = server.call("auth.login", @username, @password)
      puts "Using session key #{key}"
      out = server.call("system.deleteSystems", 
            key,
            [systemid.to_i]
            )
      puts out
    rescue XMLRPC::FaultException => e
      puts "Error:"
      puts e.faultCode
      puts e.faultString
    end
  end

  desc "Delete specific machine", "Delete the specified system from Spacewalk"
  def delete(systemid)
    server = XMLRPC::Client.new(@spacewalk_server, "/rpc/api", 80)
    puts "Delete this system from spacewalk - ID #{systemid}"

    begin
      key = server.call("auth.login", @username, @password)
      puts "Using session key #{key}"
      out = server.call("system.deleteSystems", 
            key,
            [systemid.to_i]
            )
      puts out
    rescue XMLRPC::FaultException => e
      puts "Error:"
      puts e.faultCode
      puts e.faultString
    end
  end

end