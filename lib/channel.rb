require 'sif'
require "xmlrpc/client"

class Channel < Sif::Loader

  option :name, :aliases => ['-n']
  option :summary, :aliases => ['-s']
  option :arch, :aliases => ['-a']
  option :parent, :default => '', :aliases => ['-p']
  option :checksum, :default => 'sha256'
  desc "Create channel", "Creates a new channel"
  def create(channel_label)
    server = XMLRPC::Client.new("spacewalk.elevenware.com", "/rpc/api", 80)
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
      key = server.call("auth.login", "admin", "admin")
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
