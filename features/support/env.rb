$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'fileutils'
require 'rspec/expectations'

BUZZ_LIB_PATH = File.expand_path(File.join(File.dirname(__FILE__),'..','..','lib'))

def add_to_lib_path(path)
  ENV["RUBYLIB"] = (String(ENV["RUBYLIB"]).split(File::PATH_SEPARATOR) + [path]).join(File::PATH_SEPARATOR)
end

def remove_from_lib_path(path)
  ENV["RUBYLIB"] = (String(ENV["RUBYLIB"]).split(File::PATH_SEPARATOR) - [path]).join(File::PATH_SEPARATOR)
end