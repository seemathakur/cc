Feature: Administration
	As an admin user
	I would like to perform activites that only an adminstrator can access
Background:
#WORKS WITH QA1 only.Differnt set of users needed for QA2
 Given user "1520", "S", "B554424" ,"Standard" ,"","" is ready to be reset
 Given user "10585", "A", "B554485" ,"Standard" ,"","" is ready to be reset
 Given user "1491", "A", "B55441B" ,"Standard" ,"","" is ready to be reset
 Given user "74089", "A", "B55446R" ,"Admin" ,"","" is ready to be reset
 Given user "69951", "A", "B55444Q" ,"Admin" ,"","" is ready to be reset
 Given user "73382", "H", "B55446G" ,"Standard" ,"","" is ready to be reset
 Given user "73385", "H", "B55446G" ,"Standard" ,"","" is ready to be reset
 #Given user "<usernameid>", "<Status>", "<mvruserid>" ,"<Type>","<email>","<defpassword>" is ready to be reset
   @login @admin-update-user-status
Scenario Outline: Perform admin function to update user status
      Given I am on the admin page
      When I set status "<status>" for user "<username>"
	  Then the user "<username>" should be "<status>"
   Examples: Users with different statuses  
   |username|status|
   |QA2     |Suspended|
  # |Esther  |Active   |
   @login @admin-update-user-type
Scenario Outline: Perform admin function to update user type
      Given I am on the admin page
      When I set type "<usertype>" for user "<username>"
	  Then the user "<username>" should be of type "<usertype>"
   Examples: Users with different types  
   |username|usertype|
   |QA2     |Admin|
   |Esther  |Standard|
   
   
   @login @admin-update-user-email
Scenario Outline: Perform admin function to update user email
      Given I am on the admin page
      When I set email "<email>" for user "<username>"
	  Then the user "<username>" should have email "<email>"
   Examples: Users with different types  
   |username|email|
   |QA2     |qatester2@mvrs.com|
   |Esther  |qatester2@mvrs.com|
   
   #TO DO email part
   @login @admin-add-user 
#Scenario Outline: Perform admin function to add new user
      #Given I am on the admin page
     #When I add new user under account is being added with "<firstname>","<lastname>" and "<email>"
	 # Then verify self registration message 
     # #Then click on generated register email link
      #And I fill user registation form
      #Then verify self registration confirmation mesasge
      
  # Examples: Users with different types  
   #|firstname|lastname|email|
   #|sap |na |qatester2@mvrs.com|
 
    @login @admin-delete-user
Scenario Outline: Perform admin function to delete user 
      Given I am on the admin page
      When I select user "<username>" to delete under account "<account>"
	  Then the user "<username>" should be "<status>"
   Examples: Users with different status  
   |username|status|
   |QA3   |deleted|
   
    @nologin @admin-default-password
Scenario Outline: Perform admin function to set default password for user 
      Given I login for account "B5544" user "6R" and password "Abcd.1234"
      When I click on Account Management link
      Then I set default password "<password>" ,"<pin>" and "<email>" for user "<username>","<usernameid>"
	  Then I verify profile update message
   Examples: Users with different default password
   |username|usernameid|password|pin|email|
   |6R    |74089|Hello12|1234|qatester2@mvrs.com|
   
    @nologin @admin-default-password-errors
Scenario:  Perform admin function to check default password errors 
      Given I login for account "B5544" user "6R" and password "Abcd.1234"
      When I click on Account Management link
      Then I click on Set Default Password link
      Then I submit empty request
      Then I verify empty pin alert
      Then I fill pin "1234" and submit
      Then I verify empty password alert
      Then I fill default password "Hello" and submit
      Then I verify incorrect password alert
      Then I fill default password "Hello12" and submit
      Then I verify empty email alert
      
      Then I fill email "abccom" and submit
      Then I verify incorrect email alert
      Then I fill email "sthakur@mvrs.com" and submit
	  Then I verify profile update message
      
      
     @nologin @admin-update-dmv-requestor-code
Scenario: Perform admin function to update DMV requestor code
      Given I login for account "B5544" user "6R" and password "Abcd.1234"
      When I click on Account Management link
      Then I update requestor code  for account "B5544",state "California",agreement "A1122" and expiration date 
	  Then I verify dmv request code succeess message 
   
      @nologin @admin-update-dmv-requestor-code-errors
Scenario: Perform admin function to update DMV requestor code
      Given I login for account "B5544" user "6R" and password "Abcd.1234"
      When I click on Account Management link
      Then I update requestor code  for account "B5544",state "California",agreement "A11" and expiration date  
	  Then I verify dmv request code error message 
   
   
       @login @admin-add-department
Scenario: Perform admin function to add department
      Given I am on manage department page 
      Then I add new department "TEST" 
	  Then I verify "TEST" department added to existing list
      
      @login @admin-rename-department-name
Scenario: Perform admin function to rename department name
      Given I am on manage department page 
      Then I rename old "TEST" to new "NEW TEST DEPT" department name
	  Then I verify "NEW TEST DEPT" department added to existing list
      
       @login @admin-delete-department-name
Scenario: Perform admin function to delete department name
      Given I am on manage department page 
      Then I select department "TEST" to be deleted
	  Then the department "TEST" is deleted
      
      @login @admin-activate-selected-user
  Scenario Outline: Perform admin function to activate selected user   
     Given I am on the admin page
     When I select user "<username>" with status "<oldstatus>" to be activated
     Then user "<username>" is activated as "<newstatus>"
     
    Examples: Users needs to be activated 
   |username|oldstatus|newstatus|
   |6G  |HRPending|ADRPending|
   |6H  |HRPending|ADRPending|