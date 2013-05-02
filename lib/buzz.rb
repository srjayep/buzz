#!/usr/bin/env ruby

require 'thor'
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require_relative 'channel'
require_relative 'system'
require_relative 'sif'

class BuzzLoader < Sif::Loader

  config_file '.buzz'

  class_option :host, :aliases => ['-h']
  class_option :username, :aliases => ['-u']
  class_option :password, :aliases => ['-p']

  desc "channel", "Manipulate Spacewalk channels"  
  subcommand "channel", Channel

  desc "system", "Manipulate Spacewalk systems"
  subcommand "system", System

  further_config do |x|
        x.instance_variable_set "@spacewalk_server", x.options[:host] unless x.options[:host].nil?
        x.instance_variable_set "@username", x.options[:username] unless x.options[:username].nil?
        x.instance_variable_set "@password", x.options[:password] unless x.options[:password].nil?
  end
end

