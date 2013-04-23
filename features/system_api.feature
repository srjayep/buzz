Feature: A set of API calls relating to Spacewalk systems
  As a user of Spacewalk
  In order to manage registered systems
  I want to use the buzz API

  @tag4
  Scenario: Listing systems
    Given I have provided username "george.mcintosh" password "password" and server "scylla"
    When I call the "list" method and the cassette "list_systems" is in place
    Then the result contains: 
    """
    [{:id=>1000021207, :name=>"AU-ASGR-EM-Test", :last_checkin=>2013-04-09 16:47:05 UTC}, {:id=>1000021206, :name=>"AU-ASGR-Mysql-Test", :last_checkin=>2013-04-09 16:39:04 UTC}, {:id=>1000021205, :name=>"AU-ASGR-Plato-Test", :last_checkin=>2013-04-09 16:31:22 UTC}, {:id=>1000020574, :name=>"augs-unzliab01", :last_checkin=>2013-03-14 12:12:12 UTC}, {:id=>1000020826, :name=>"augs-unzliab01", :last_checkin=>2013-04-23 10:56:07 UTC}, {:id=>1000020608, :name=>"augs-unzliab02", :last_checkin=>2013-04-23 10:44:56 UTC}, {:id=>1000020140, :name=>"AusDevlop_RH4", :last_checkin=>2013-04-23 05:38:51 UTC}]
    """
