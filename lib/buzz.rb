#!/usr/bin/env ruby

require 'thor'
require 'extensions/kernel' unless Kernel.respond_to? 'require_relative'
require_relative 'channel'
require_relative 'system'

class Buzz < Thor

  desc "channel", "Manipulate Spacewalk channels"  
  subcommand "channel", Channel

  desc "system", "Manipulate Spacewalk systems"
  subcommand "system", System

end
