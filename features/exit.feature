Feature: exit statuses

  In order to specify expected exit statuws
  As a developer using Cucumber
  I want to use the "the exit status should be" step

  Scenario: exit status of 0
    When I run "ruby -h"
    Then the exit status should be 0

  Scenario: non-zero exit status
    When I run "ruby -e 'exit 55'"
    Then the exit status should be 55
