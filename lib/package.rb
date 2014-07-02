
require 'sif'

require "xmlrpc/client"
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require 'buzz/package_api'
require 'base64'
require 'tempfile'
require 'greenletters'

class Package < Sif::Loader

  option :name, :aliases => ['-n'], :required => true
  option :version, :aliases => ['-v'], :required => true
  option :release, :aliases => ['-r'], :required => true
  option :epoch, :aliases => ['-e'], :required => false, :default => ''
  option :arch, :aliases => ['-a'], :required => true
  desc "findByNvrea", "This call allows you to get the details of a package from Spacewalk"
  def findByNvrea()
    package_api = Buzz::Api::Package.new(@spacewalk_server, @username, @password)
    response = package_api.findByNvrea(options[:name], options[:version], options[:release], options[:epoch], options[:arch])
    puts "RES #{response}"
  end 

  option :name, :aliases => ['-n'], :required => true
  option :version, :aliases => ['-v'], :required => true
  option :release, :aliases => ['-r'], :required => true
  option :epoch, :aliases => ['-e'], :required => false, :default => ''
  option :arch, :aliases => ['-a'], :required => true
  option :outputfile, :aliases => ['-o']
  desc "getPackage", "This call allows you to download an RPM from Spacewalk"
  def getPackage()
    package_api = Buzz::Api::Package.new(@spacewalk_server, @username, @password)
    dest_file = package_api.getPackage(options[:name], options[:version], options[:release], options[:epoch], options[:arch], options[:outputfile])
    puts "RES Saved to #{dest_file}"
  end

  option :name, :aliases => ['-n'], :required => true
  option :version, :aliases => ['-v'], :required => true
  option :release, :aliases => ['-r'], :required => true
  option :epoch, :aliases => ['-e'], :required => false, :default => ''
  option :arch, :aliases => ['-a'], :required => true
  option :all, :required => false, :type => :boolean, :default => false
  desc "removePackage", "This call allows you to delete an RPM from Spacewalk"
  def removePackage()
    package_api = Buzz::Api::Package.new(@spacewalk_server, @username, @password)
    package_api.removePackage(options[:name], options[:version], options[:release], options[:epoch], options[:arch], options[:all])
    file_name = "#{options[:name]}-#{options[:version]}-#{options[:release]}.#{options[:arch]}.rpm"
    puts "RES Removed package #{file_name}"
  end

  option :name, :aliases => ['-n'], :required => true
  option :version, :aliases => ['-v'], :required => true
  option :release, :aliases => ['-r'], :required => true
  option :epoch, :aliases => ['-e'], :required => false, :default => ''
  option :arch, :aliases => ['-a'], :required => true
  option :all, :required => false, :type => :boolean, :default => false
  desc "listProvidingChannels", "This call allows you to find what channels an RPM is on in Spacewalk"
  def listProvidingChannels()
    package_api = Buzz::Api::Package.new(@spacewalk_server, @username, @password)
    response = package_api.listProvidingChannels(options[:name], options[:version], options[:release], options[:epoch], options[:arch], options[:all])
    puts "RES #{response}"
  end

  option :name, :aliases => ['-n'], :required => true
  option :version, :aliases => ['-v'], :required => true
  option :release, :aliases => ['-r'], :required => true
  option :epoch, :aliases => ['-e'], :required => false, :default => ''
  option :arch, :aliases => ['-a'], :required => true
  option :gpgkey, :aliases => ['-k'], :required => true
  option :passphrase
  desc "resignRpm", "This call allows you to download an RPM, sign it & push it, overwriting old RPM on Spacewalk"
  def resignRpm()
    package_api = Buzz::Api::Package.new(@spacewalk_server, @username, @password)

    channel_list = package_api.listProvidingChannels(options[:name], options[:version], options[:release], options[:epoch], options[:arch]).map{|channel| channel['label']}

    dest_file = Tempfile.new(['buzz', '.rpm'])
    package_api.getPackage(options[:name], options[:version], options[:release], options[:epoch], options[:arch], dest_file.path)

    command = "rpm --define \"_gpg_name #{options[:gpgkey]}\" --addsign #{dest_file.path}"

    rpmsign = Greenletters::Process.new(command, {:transcript => $stdout, :timeout => 300})

    rpmsign.start!

    rpmsign.wait_for(:output, /^Enter pass phrase: $/)
    rpmsign << "#{options[:passphrase] || @passphrase}\n"

    rpmsign.wait_for(:exit)

    cmd = ["rhnpush", "--server", @spacewalk_server, "-u", @username, "-p", @password]

    channel_list.each do |channel_label|
      cmd << "-c"
      cmd << channel_label
    end

    cmd << dest_file.path

    package_api.removePackage(options[:name], options[:version], options[:release], options[:epoch], options[:arch])
    system(*cmd)

    puts "RES Resigned package pushed to #{channel_list}"
  end

end
