Feature: A set of API calls relating to Spacewalk systems
  As a user of Spacewalk
  In order to manage registered systems
  I want to use the buzz API

  Scenario: Listing systems
    Given I have provided username "admin" password "admin" and server "spacewalk.elevenware.com"
    When I call the "list" method and the cassette "list_systems" is in place
    Then the result contains the array: 
    """
    [{:id=>"1000010010", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:36 UTC"}, {:id=>"1000010011", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:39 UTC"}, {:id=>"1000010012", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:42 UTC"}, {:id=>"1000010013", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:44 UTC"}, {:id=>"1000010014", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:46 UTC"}, {:id=>"1000010015", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:48 UTC"}, {:id=>"1000010016", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:50 UTC"}, {:id=>"1000010017", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:51 UTC"}, {:id=>"1000010018", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:53 UTC"}, {:id=>"1000010019", :name=>"localhost.localdomain", :last_checkin=>"2013-04-23 01:11:55 UTC"}, {:id=>"1000010001", :name=>"spacewalk.elevenware.com", :last_checkin=>"2013-03-17 21:25:39 UTC"}, {:id=>"1000010002", :name=>"spacewalk.elevenware.com", :last_checkin=>"2013-04-20 16:04:37 UTC"}]
    """

  Scenario: Deleting a system by ID
    Given I have provided username "admin" password "admin" and server "spacewalk.elevenware.com"
    When I call the "delete_systems" method with the arguments "1000010018" and the cassette "delete_system" is in place
    Then the result contains:
    """
    1
    """