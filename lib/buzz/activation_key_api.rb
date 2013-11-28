require 'rexml/document'
require 'rexml/xpath'
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require 'buzz/api_base'

module Buzz
  module Api
    class ActivationKey < ApiBase

      def initialize(server, username, password)
        super(server, username, password)
      end

      def list(options = {})
          response = make_call("activationkey.listActivationKeys")
          parse_activation_key_list(response, options)
      end

      private
      def parse_activation_key_list(response, options)
        activation_keys = options[:key] ? response.select { |activation_key|
          Regexp.new(options[:key]) === activation_key['key']
        } : response

        activation_keys = options[:description] ? activation_keys.select { |activation_key|
          Regexp.new(options[:description], Regexp::IGNORECASE) === activation_key['description']
        } : activation_keys

        activation_keys = options[:channel_label] ? activation_keys.select { |activation_key|
          regexp = Regexp.new(options[:channel_label], Regexp::IGNORECASE)
          regexp === activation_key['base_channel_label'] ||
            activation_key['child_channel_labels'].any? { |label| regexp === label }
        } : activation_keys

        options[:verbose] ? activation_keys :
          activation_keys.map { |activation_key|
            {
              :key         => activation_key['key'],
              :description => activation_key['description']
            }
          }
      end

    end
  end
end