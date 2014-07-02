require 'rexml/document'
require 'rexml/xpath'
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require 'buzz/api_base'
require 'open-uri'

module Buzz
  module Api
    class Package < ApiBase

      def initialize(server, username, password)
        super(server, username, password)
      end

      def findByNvrea(name, version, release, epoch, arch)
        make_call("packages.findByNvrea", name, version, release, epoch, arch)
      end

      def getPackage(name, version, release, epoch, arch, outputfile = nil)
        package_details = findByNvrea(name, version, release, epoch, arch)
        num_packages = package_details.length
        if num_packages < 1
          abort("No matching packages found")
        elsif num_packages > 1
          abort("Multiple packages found - sorry this call won't work for multiple packages")
        else
          package_id = package_details[0]["id"]
          package_url  = make_call("packages.getPackageUrl", package_id)
          file_name = "#{name}-#{version}-#{release}.#{arch}.rpm"
          dest_file = outputfile || file_name
          open(dest_file, 'wb') do |file|
            file << open(package_url).read
          end
          dest_file
        end
      end

      def removePackage(name, version, release, epoch, arch, all = false)
        package_details = findByNvrea(name, version, release, epoch, arch)
        num_packages = package_details.length
        if num_packages < 1
          abort("No matching packages found")
        elsif num_packages > 1 && !allows
          abort("Multiple packages found - to remove all specify \"--all\"")
        else
          package_details.each do |package_detail|
            package_id = package_detail["id"]
            make_call("packages.removePackage", package_id)
          end
        end
      end

      def listProvidingChannels(name, version, release, epoch, arch, all = false)
        package_details = findByNvrea(name, version, release, epoch, arch)
        num_packages = package_details.length
        if num_packages < 1
          abort("No matching packages found")
        elsif num_packages > 1 && !all
          abort("Multiple packages found - to remove all specify \"--all\"")
        else
          channels = []
          package_details.each do |package_detail|
            package_id = package_detail["id"]
            new_channels = make_call("packages.listProvidingChannels", package_id)
            new_channels.each do |channel|
              channels << channel
            end
          end
          channels
        end
      end

    end
  end
end
