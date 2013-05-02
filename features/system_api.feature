Feature: A set of API calls relating to Spacewalk systems
  As a user of Spacewalk
  In order to manage registered systems
  I want to use the buzz API

Background: I configure the library
   Given I have provided username "admin" password "admin" and server "spacewalk.elevenware.com"
   And want to use the "System" API

  Scenario: Listing systems
    When I call the "list" method and the cassette "list_systems" is in place
    Then the result contains the array: 
    """
    [{:id=>"1000010010", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:36 2013"}, {:id=>"1000010011", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:39 2013"}, {:id=>"1000010012", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:42 2013"}, {:id=>"1000010013", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:44 2013"}, {:id=>"1000010014", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:46 2013"}, {:id=>"1000010015", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:48 2013"}, {:id=>"1000010016", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:50 2013"}, {:id=>"1000010017", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:51 2013"}, {:id=>"1000010018", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:53 2013"}, {:id=>"1000010019", :name=>"localhost.localdomain", :last_checkin=>"Tue Apr 23 01:11:55 2013"}, {:id=>"1000010001", :name=>"spacewalk.elevenware.com", :last_checkin=>"Sun Mar 17 21:25:39 2013"}, {:id=>"1000010002", :name=>"spacewalk.elevenware.com", :last_checkin=>"Sat Apr 20 16:04:37 2013"}]
    """

  Scenario: Deleting a system by ID
    When I call the "delete_systems" method with the arguments "1000021466" and the cassette "delete_system" is in place
    Then the result contains:
    """
    1
    """

  Scenario: Listing systems by regex
   When I call the "list_by_regex" method with the arguments "^store3" and the cassette "list_systems_by_regex" is in place
    Then the result contains the array:
    """
    [{:id=>"1000021430", :name=>"store3.eng.uk.specsavers.com", :last_checkin=>"Mon Apr 22 12:57:58 2013"}, {:id=>"1000021494", :name=>"store3.eng.uk.specsavers.com", :last_checkin=>"Wed Apr 24 13:15:09 2013"}, {:id=>"1000021418", :name=>"store3.eng.uk.specsavers.com", :last_checkin=>"Fri Apr 19 16:46:16 2013"}, {:id=>"1000021563", :name=>"store3.eng.uk.specsavers.com", :last_checkin=>"Wed May  1 12:59:36 2013"}]
    """