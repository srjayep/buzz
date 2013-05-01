$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'fileutils'
require 'rspec/expectations'
require 'buzz/system_api'
require 'buzz/channel_api'
require 'aruba/in_process'

BUZZ_LIB_PATH = File.expand_path(File.join(File.dirname(__FILE__),'..','..','lib'))

Before do
  @aruba_timeout_seconds = 5
  @original_path = ENV['PATH'].split(File::PATH_SEPARATOR)
  @original_home = ENV['HOME']
  new_home = "/tmp/fakehome"
  FileUtils.rm_rf new_home
  FileUtils.mkdir new_home
  ENV['HOME'] = new_home
end

After do |scenario|
  ENV['RUBYLIB'] = ''
  ENV['PATH'] = @original_path.join(File::PATH_SEPARATOR)
  ENV['HOME'] = @original_home
end

def put_config_in_place(config_file)
   FileUtils.cp config_file, "#{ENV['HOME']}/.buzz"
end

def add_to_lib_path(path)
  ENV["RUBYLIB"] = (String(ENV["RUBYLIB"]).split(File::PATH_SEPARATOR) + [path]).join(File::PATH_SEPARATOR)
end

def remove_from_lib_path(path)
  ENV["RUBYLIB"] = (String(ENV["RUBYLIB"]).split(File::PATH_SEPARATOR) - [path]).join(File::PATH_SEPARATOR)
end