
require 'sif'

require "xmlrpc/client"

class Channel < Sif::Loader

  desc "Regenerate YUM cache", "This call allows you to force the re-generation of the YUM cache for the specified channel"
  def refresh(channel_label)
      server = XMLRPC::Client.new(@spacewalk_server, "/rpc/api", 80)
      puts "Regenerating YUM cache for #{channel_label}"
     
      begin
        key = server.call("auth.login", @username, @password)
        puts "Using session key #{key}"
        out = server.call("channel.software.regenerateYumCache", 
              key,
              channel_label
              )
        puts out
      rescue XMLRPC::FaultException => e
        puts "Error:"
        puts e.faultCode
        puts e.faultString
      end
  end 

  option :name, :aliases => ['-n']
  option :summary, :aliases => ['-s']
  option :arch, :aliases => ['-a']
  option :parent, :default => '', :aliases => ['-p']
  option :checksum, :default => 'sha256'
  desc "Create channel", "Creates a new channel"
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

end
