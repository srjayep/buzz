Feature: A set of API calls relating to Spacewalk activation keys
  As a user of Spacewalk
  In order to manage activation keys
  I want to use the buzz API
  
  Background: Use the "ActivationKey" API
    Given I have provided username "admin" password "admin" and server "spacewalk.elevenware.com"
    And want to use the "ActivationKey" API

  Scenario: List activation keys
    When I call the "list" method and the cassette "list_activation_keys" is in place
    Then the result contains the array:
    """
    [{:key=>"2-activation-key", :description=>"Store GB D2 Deployment RHEL6 WS X86"}]
    """

Scenario: Filter activation keys by key
    When I call the "list" method with the hash "{:key => '^2-'}" and the cassette "list_activation_keys" is in place
    Then the result contains the array:
    """
    [{:key=>"2-activation-key", :description=>"Store GB D2 Deployment RHEL6 WS X86"}]
    """

Scenario: Filter activation keys by description
    When I call the "list" method with the hash "{:description => '^Store'}" and the cassette "list_activation_keys" is in place
    Then the result contains the array:
    """
    [{:key=>"2-activation-key", :description=>"Store GB D2 Deployment RHEL6 WS X86"}]
    """

Scenario: Filter activation keys by child channel
    When I call the "list" method with the hash "{:channel_label => '^Child'}" and the cassette "list_activation_keys" is in place
    Then the result contains the array:
    """
    [{:key=>"2-activation-key", :description=>"Store GB D2 Deployment RHEL6 WS X86"}]
    """

Scenario: Filter activation keys by child channel with no matches
    When I call the "list" method with the hash "{:channel_label => '^Child49'}" and the cassette "list_activation_keys" is in place
    Then the result contains the array:
    """
    []
    """

