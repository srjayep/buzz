Feature: Users can override config on the command line

  In order to use a different Spacewalk host
  As a user of buzz 
  I want to use command line options to indicate this 

  @announce
  Scenario: I run buzz with the --host option
    Given I have buzz installed
    And the config is "sample_config/complete.yaml"
    And I run `buzz system list --host=spacewalk.elevenware.com` using the cassette "something"
    Then the output should contain:
   """
   System: ID: 1000010000 name: client last checked in: 2013-03-17 21:07:06 UTC
   System: ID: 1000010001 name: spacewalk.elevenware.com last checked in: 2013-03-17 21:25:39 UTC
   System: ID: 1000010002 name: spacewalk.elevenware.com last checked in: 2013-04-20 16:04:37 UTC
  """
 
  
