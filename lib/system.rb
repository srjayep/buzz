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
    delete_systems [systemid.to_i]
   
  end

  desc "Delete specific machine", "Delete the specified system from Spacewalk"
  def delete(systemid)
    
    puts "Delete this system from spacewalk - ID #{systemid}"
    delete_systems [systemid.to_i]
   
  end

  desc "List systems", "List all subscribed systems"
  def list
     server = XMLRPC::Client.new(@spacewalk_server, "/rpc/api", 80)
      begin
        key = server.call("auth.login", @username, @password)
        puts "Using session key #{key}"
        response = server.call("system.listSystems", 
              key
            )
        systems = []
        response.each do |system|
          id = system['id']
          name = system['name']
          last_checkin = system['last_checkin'].to_time
          puts "System: ID: #{id} name: #{name} last checked in: #{last_checkin}"
        end
      rescue XMLRPC::FaultException => e
        puts "Error:"
        puts e.faultCode
        puts e.faultString
      end 
    end

    desc "List by regex", "list"
    def list_by_regex(regex)
      
        systems = find_systems_by_regex(regex)
        systems.each do |system|
          id = system['id']
          name = system['name']
          last_checkin = system['last_checkin'].to_time
          puts "System: ID: #{id} name: #{name} last checked in: #{last_checkin}"
        end
      
    end

    desc "Delete by regex", "Delete all systems whose name matches the regex supplied"
    def delete_by_regex(regex)
      systems_to_delete = find_systems_by_regex regex
      system_ids = systems_to_delete.collect { |system| system['id']}
      system_ids.each { |it| puts "Deleting #{it}"}
      delete_systems system_ids
    end

  no_tasks do 

    def delete_systems(system_ids) 
      server = XMLRPC::Client.new(@spacewalk_server, "/rpc/api", 80)
      
      begin
        key = server.call("auth.login", @username, @password)
        puts "Using session key #{key}"
        out = server.call("system.deleteSystems", 
              key,
              system_ids
            )
        puts out
      rescue XMLRPC::FaultException => e
        puts "Error:"
        puts e.faultCode
        puts e.faultString
      end 
    end

    def find_systems_by_regex(regex)
      
      server = XMLRPC::Client.new(@spacewalk_server, "/rpc/api", 80)
      systems = []
        begin
          key = server.call("auth.login", @username, @password)
          puts "Using session key #{key}"
          systems = server.call("system.searchByName", 
              key,
              regex
           )
        rescue XMLRPC::FaultException => e
          puts "Error:"
          puts e.faultCode
          puts e.faultString 
        end
       systems
    end

  end

end