Feature: A set of API calls relating to Spacewalk channels
  As a user of Spacewalk
  In order to manage channels
  I want to use the buzz API

  Scenario: Refresh a channel
    Given I have provided username "admin" password "admin" and server "spacewalk.elevenware.com"
    And wish to use the "Channel" API
    When I call the "refresh_channel" method with the arguments "my-awesome-channel" and the cassette "refresh_channel" is in place
    Then the result contains:
    """
    1
    """