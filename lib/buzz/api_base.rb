require "xmlrpc/client"

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

    end
  end
end