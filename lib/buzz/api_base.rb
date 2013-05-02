require "xmlrpc/client"
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'

module Buzz
  module Api
    class ApiBase

    	def initialize(server, username, password)
          @server = server
          @username = username
          @password = password
          @spacewalk = XMLRPC::Client.new(@server, "/rpc/api", 80)
        end

        def get_key
          @key = @spacewalk.call("auth.login", @username, @password) unless @key
          @key
        end

        def make_call(method_name, *args)
        	
    	  begin
    	  	if ( args.length == 0 )

              response = @spacewalk.call(method_name,
                get_key
              )
            else 
              args.unshift(get_key)
             
              response = @spacewalk.call(method_name,
              
              	*args
              	)
             end
          response
          rescue XMLRPC::FaultException => e
            puts "Error:"
            puts e.faultCode
            puts e.faultString
          end 
        end

    end
  end
end