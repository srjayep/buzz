require 'rexml/document'
require 'rexml/xpath'
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require_relative 'api_base'

module Buzz
  module Api
    class System < ApiBase

        def initialize(server, username, password)
          super(server, username, password)
        end

        def list
            response = make_call("system.listSystems")
            parse_system_list(response)
        end

        def list_by_regex(regex)
            response = make_call("system.searchByName", regex)
            parse_system_list(response)

        end

        def delete_systems(system_ids) 
          system_ids =  system_ids.respond_to?('collect') ? system_ids.collect { |id| id.to_i} : system_ids.to_i
          out = make_call("system.deleteSystems", system_ids)
          out 
        end

        private
        def parse_system_list(response)
          systems = []
          response.each do |system|
            id = system['id']
            name = system['name']
            last_checkin = system['last_checkin'].to_time.ctime
            systems << { :id => "#{id}", :name => "#{name}", :last_checkin => "#{last_checkin}" }
          end
          systems
        end

    end
  end
end