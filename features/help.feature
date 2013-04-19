Feature: Get help


  Scenario: Help
    Given I provide no options
    Then I should see
    """
   Commands:
  buzz channel         # Manipulate Spacewalk channels
  buzz help [COMMAND]  # Describe available commands or one specific command
  buzz system          # Manipulate Spacewalk systems

Options:
  -c, [--config=CONFIG]      
  -h, [--host=HOST]          
  -u, [--username=USERNAME]  
  -p, [--password=PASSWORD]
  """ 
