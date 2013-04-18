#!/usr/bin/env ruby

require 'thor'
require_relative './channel'

class Buzz < Thor

  

  desc "channel", "Manipulate Spacewalk channels"  
  subcommand "channel", Channel
end
