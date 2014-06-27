
require 'sif'

require "xmlrpc/client"
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require 'buzz/channel_api'

class Channel < Sif::Loader

  desc "refresh CHANNEL_LABEL", "This call allows you to force the re-generation of the YUM cache for the specified channel"
  def refresh(channel_label)

      puts "Regenerating YUM cache for #{channel_label}"
      channel_api = Buzz::Api::Channel.new(@spacewalk_server, @username, @password)
      response = channel_api.refresh_channel(channel_label)
      puts "RES #{response}"

  end 

  option :name, :aliases => ['-n']
  option :summary, :aliases => ['-s']
  option :arch, :aliases => ['-a']
  option :parent, :default => '', :aliases => ['-p']
  option :checksum, :default => 'sha256'
  desc "create CHANNELNAME [options]", "Creates a new channel"
  def create(channel_label)
    server = XMLRPC::Client.new(@spacewalk_server, "/rpc/api", 80)
    puts "Creating #{channel_label}"
    puts "Name #{options[:name]}"
    puts "Summary #{options[:summary]}"
    puts "Arch #{options[:arch]}"
    puts "Parent #{options[:parent]}"
    puts "Checksum #{options[:checksum]}"
    name = options[:name]
    summary = options[:summary]
    archLabel = "channel-#{options[:arch]}"   
    parent = options[:parent]
    checksum = options[:checksum]

    begin
      key = server.call("auth.login", @username, @password)
      puts "Using session key #{key}"
      out = server.call("channel.software.create", 
            key,
            channel_label,
            name,
            summary,
            archLabel,
            parent,
            checksum
            )
      puts out
    rescue XMLRPC::FaultException => e
      puts "Error:"
      puts e.faultCode
      puts e.faultString
    end
  end

  desc "systems CHANNEL_LABEL", "List subscribed systems"
  def systems(channel_label)
    puts "Listing systems subscribed to #{channel_label}"
    api = Buzz::Api::Channel.new(@spacewalk_server, @username, @password)
    response = api.get_subscribed_systems(channel_label)
    pp response
  end

  desc "sync_repo CHANNEL_LABEL", "Trigger immediate repo synchronization"
  def sync_repo(channel_label)
    puts "Syncing repositories for #{channel_label}"
    api = Buzz::Api::Channel.new(@spacewalk_server, @username, @password)
    response = api.sync_repo(channel_label)
    puts ( response == 1 ? 'Respository sync triggered' : 'Respository sync failed' )
  end

end
