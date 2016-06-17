Feature: Login
Background:
Given the password is reset for userid "74088"
Given the password is reset for userid "74089"
Given the password is reset for userid "73857"
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

@login-only 	
Scenario: Login to WebMVR with multiple invalid credentials
Given I login for account "B5544" user "6Q" and password "Abcd.12345"
Then I am not logged in
Given I login for account "B5544" user "6Q" and password "Abcd.12346"
Then I am not logged in
Given I login for account "B5544" user "6Q" and password "Abcd.12345"
Then I am not logged in
Given I login for account "B5544" user "6Q" and password "Abcd.12345"
Then I am locked out