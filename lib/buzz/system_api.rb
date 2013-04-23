require 'rexml/document'
require 'rexml/xpath'
require "xmlrpc/client"

module Buzz
  module Api
    class System

        def initialize(server, username, password)
          @server = server
          @username = username
          @password = password
        end

        def list
          server = XMLRPC::Client.new(@server, "/rpc/api", 80)
          begin
            key = server.call("auth.login", @username, @password)
            response = server.call("system.listSystems", 
               key
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

    end
  end
end