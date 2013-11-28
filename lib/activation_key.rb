
require 'sif'
require 'buzz/activation_key_api'
require 'pp'

class ActivationKey < Sif::Loader

  option :description, :aliases => ['-d']
  option :key, :aliases => ['-k']
  option :channel_label, :aliases => ['-l']
  option :verbose, :aliases => ['-v']
  desc "list", "List activation keys"
  def list

      puts "Listing all activation keys"
      activation_key_api = Buzz::Api::ActivationKey.new(@spacewalk_server, @username, @password)
      response = activation_key_api.list(options)
      pp response

  end

end
