# buzz

Buzz is a command-line interface into Spacewalk/RHN Satellite, written in Ruby. It will work with Ruby 1.8, which is the default Ruby on a lot of systems.

## Introduction

The buzz command itself has several sub-commands for manipulating different aspects of your Spacewalk.

* channel - for manipulating channels
* system  - for manipulating systems

## Configuration

By default, Buzz will look at $HOME/.buzz for it's (YAML) config, which looks a bit like this

    spacewalk_server:  spacewalk.mycompany.com
    username        :  my.user.name
    password        :  my_spacewalk_password

You can point Buzz at other config files using the -c flag

    $ buzz system list -c=./other.conf

## The channel commands

### Create

You can create a new channel in Spacewalk using

option :name, :aliases => ['-n']
  option :summary, :aliases => ['-s']
  option :arch, :aliases => ['-a']
  option :parent, :default => '', :aliases => ['-p']
  option :checksum, :default => 'sha256'

    $ buzz channel create <LABEL> -n <name> -s <summary> -a <architecture> -p <parent-label> --checksum <checksumType>

Checksum type will default to sha256

## The system commands

### list 

List all registered systems

    $ buzz system list

### list_by_regex

List all registered systems whose name (hostname) matches the provided regex

    $ buzz system list_by_regex "^testbox.*"

Will list all the systems whose hostname begins with testbox

### deleteself

    $ buzz system deleteself

This will de-register the box it is run on from Spacewalk. Handy if you spin up and tear down VMs all the time. Use this command in your tear down scripts.

### delete

Delete a specific system by ID

    $ buzz system delete <SYSTEMID>

### delete_by_regex

Delete all registered systems whose name (hostname) matches the provided regex

    $ buzz system delete_by_regex "^testbox.*"

Will delete all the systems whose hostname begins with testbox. Be careful!

## Completeness

Buzz is far from a complete implementation. I tend to build a tool to do exactly what I need at that time, and extend it as I need to, or find time, or am asked to. 


## Contributing to buzz
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 George McIntosh. See LICENSE.txt for
further details.

