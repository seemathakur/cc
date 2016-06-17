Feature: Login
Background:
Given the password is reset for userid "74088"
Given the password is reset for userid "74089"
Given the password is reset for userid "73907"
#Given the password is reset for userid "73857"
# Uses Before and After hooks to perform actual login/logout (see: features/support/hooks.rb)

@login-only 
Scenario: Login to WebMVR with valid credentials
Given I login for account "B5544" user "6Q" and password "Abcd.1234"
Then I am logged in
Then I logout


@login-only 	
Scenario: Login to WebMVR with invalid credentials
Given I login for account "B5544" user "6Q" and password "Abcd.12345"
Then I am not logged in
	
@change-password	@login-only 
Scenario: Change password
When I request for change password 
Then I login as user "6Q",old password "Abcd.1234" and the new password "Abc.1234" for account "B5544"
Then I verify password change success message
Then I re-login as "B5544","6Q" and "Abc.1234"
Then I am logged in
Then I logout

	
@forgot-password @security-question-one @login-only 
Scenario: Forgot/expired password updation via using security questions one
    When I request for security questions 
	Then I answer security question one correctly
	Then I change password "Abc.1234"
	Then I verify password change success message
    Then I re-login as "B5544","6Q" and "Abc.1234"
    Then I am logged in
    Then I logout
	
	
@forgot-password @security-question-two @login-only 
Scenario: Forgot/expired password updation via using security questions two
    When I request for security questions 
	Then I answer security question one incorrectly
	Then I change password "Abc.1234"
	Then I verify password change success message
    Then I re-login as "B5544","6Q" and "Abc.1234"
    Then I am logged in
    Then I logout
	
@forgot-password @incorrect-security-questions @login-only 
Scenario: Forgot/expired password failure using incorrect security questions 
    When I request for security questions 
	Then I answer security questions incorrectly
	Then verify I am on Technical Support page
	
#@forgot-password  @email  @login-only-qathree
#Scenario: Forgot/expired password updation via using email account
   # Given I forgot my password
	#When I request a new password for account "B5544",user "6P" and email "qatester2@mvrs.com"
	#Then I should receive a temporary password via email
	#Then I verify password change by email message
	#Then I login as user "6P",old password "Abcd.1234" and the new password "Abc.1234" for account "B5544"
    #Then I verify password change success message
