require 'rexml/document'
require 'rexml/xpath'
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require 'buzz/api_base'

module Buzz
  module Api
    class Channel < ApiBase

      def initialize(server, username, password)
        super(server, username, password)
      end

      def refresh_channel(channel_label)
        make_call("channel.software.regenerateYumCache", channel_label)
      end

      def get_subscribed_systems(channel_label)
        make_call("channel.software.listSubscribedSystems", channel_label)
      end

      def sync_repo(channel_label)
        make_call("channel.software.syncRepo", channel_label)
      end

    end
  end
end