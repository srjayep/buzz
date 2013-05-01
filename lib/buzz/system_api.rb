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
            systems = []
            response = make_call("system.listSystems")
            response.each do |system|
              id = system['id']
              name = system['name']
              last_checkin = system['last_checkin'].to_time.ctime
              systems << { :id => "#{id}", :name => "#{name}", :last_checkin => "#{last_checkin}" }
            end
            systems
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
          system_ids = system_ids.collect { |id| id.to_i}
         
          begin
           #out = @spacewalk.call("system.deleteSystems", 
           #   get_key,
           #   system_ids
           # )
            out = make_call("system.deleteSystems", system_ids)
            out
          rescue XMLRPC::FaultException => e
            puts "Error:"
            puts e.faultCode
            puts e.faultString
          end 
        end

    end
  end
end