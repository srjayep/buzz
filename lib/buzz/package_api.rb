require 'rexml/document'
require 'rexml/xpath'
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require 'buzz/api_base'

module Buzz
  module Api
    class Package < ApiBase

      def initialize(server, username, password)
        super(server, username, password)
      end

      def findByNvrea(name, version, release, arch)
        make_call("channel.packages.findByNvrea", name, version, release, '', arch)
      end

    end
  end
end
