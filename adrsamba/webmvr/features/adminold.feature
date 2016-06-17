Feature: Administration
	As an admin user
	I would like to perform activites that only an adminstrator can access
Background:
Given status is activated for userid "1520"
 Given status is suspended for userid "10585" 
 
@login
Scenario: Perform admin function to suspend user
      Given I am on the admin page
      When I set status "Suspended" for user "QA2"
	  Then the user "QA2" should be "Suspended"
      
@login
Scenario: Perform admin function to activate user
      Given I am on the admin page
      When I set status "Active" for user "ESTHER"
	  Then the user "ESTHER" should be "Active"