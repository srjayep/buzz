
require 'sif'

require "xmlrpc/client"
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require 'buzz/package_api'

class Package < Sif::Loader

  option :name, :aliases => ['-n']
  option :version, :aliases => ['-v']
  option :release, :aliases => ['-r']
  option :arch, :aliases => ['-a']
  desc "findByNvrea", "This call allows you to get the details of a package from Spacewalk"
  def findByNvrea()

      package_api = Buzz::Api::Package.new(@spacewalk_server, @username, @password)
      response = package_api.findByNvrea(options[:name], options[:version], options[:release], options[:arch])
      puts "RES #{response}"

  end 

end
