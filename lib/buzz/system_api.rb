require 'rexml/document'
require 'rexml/xpath'

require 'buzz/api_base'

module Buzz
  module Api
    class System < ApiBase

        def initialize(server, username, password)
          super(server, username, password)
        end

        def list
          begin
            response = @spacewalk.call("system.listSystems", 
               get_key
            )
            systems = []
            response.each do |system|
              id = system['id']
              name = system['name']
              last_checkin = system['last_checkin'].to_time
              systems << { :id => "#{id}", :name => "#{name}", :last_checkin => "#{last_checkin}" }
            end
            systems
          rescue XMLRPC::FaultException => e
            puts "Error:"
            puts e.faultCode
            puts e.faultString
          end 
        end

        def deleteself
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

        def delete_systems(system_ids) 
        
          begin
            puts "Using session key #{key}"
            out = server.call("system.deleteSystems", 
                  get_key,
                  system_ids
                )
            puts out
          rescue XMLRPC::FaultException => e
            puts "Error:"
            puts e.faultCode
            puts e.faultString
          end 
        end

    end
  end
end