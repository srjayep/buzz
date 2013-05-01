require 'rexml/document'
require 'rexml/xpath'

require 'buzz/api_base'

module Buzz
  module Api
    class Channel < ApiBase

        def initialize(server, username, password)
          super(server, username, password)
        end

        def refresh_channel(channel_label)
          out = make_call("channel.software.regenerateYumCache", channel_label)
          out
        end

    end
  end
end