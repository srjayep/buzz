Feature: help is displayed

  In order to ensure I get help
  As a user of buzz 
  I want to invoke buzz with no arguments 

  Scenario: I run buzz with no arguments at all 
    Given I have buzz installed
    And the config is "sample_config/complete.yaml"
    When I run `buzz`
    Then the output should contain:
   """
  Commands:
     buzz channel         # Manipulate Spacewalk channels
     buzz help [COMMAND]  # Describe available commands or one specific command
  """
 
