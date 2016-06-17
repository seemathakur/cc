Feature: Reports View

# All scenarios use Before and After hooks to perform login/logout
# See features/support/hooks.rb for details of available tags. 
@view-pending-report-ca-driver
Scenario: View driver license in Pending Report Page
    Given I login as "6P" "Abcd.1234"
    And user "B55446P" is ordering a DL using driver data:
        		
		| state      | New York         | 
        |ordertype   | DL               |
        |producttype |NY DL 3Y Overnight|	
        |purpose     |Insurance         |		
        | lastname   | REBBECCAQA       |  
        | firstname  | JULIENEQA        |  
	    #| middlename | mid             | 
       #|billcode    | 10               |  	   
        |   dln      | 299683649        |  
       #|    dob     |01/12/1985        |
		|statecode   |NY                |
        | misc       | PENDING_REPORT   |  
       #| gender     | Male             |  
	   #|resultflag  |Status: VALID     |
		
	   
    When I place the DL order 
    Then I should see the DL order on "Pending Reports" page
	Then I logout
@view-unread-report-ca-driver
Scenario: View driver license in Unread Report Page
    Given I login as "6P" "Abcd.1234"
    And user "B55446P" is ordering a DL using driver data:
        | state      | California     | 
        |ordertype   | DL             |
        |producttype |CA DL 3Y Instant|	
        |purpose     |Insurance       |		
        | lastname   | KIMBERLYQA     |  
       	|   dln      | E1111111       |  
       	|statecode   |CA              |
        | misc       | MVR_CA_UNREAD_REPORT  |  
        |resultflag  |Status: VALID  |
		
			   
    When I place the DL order 
    Then I should see the DL order on "Unread Reports" page
	Then I should verify the full dl report in popup under "Unread Reports" page
    
	Then I logout

   
   @view-archive-report-ca-driver
Scenario: View driver in Archive Report Page
    Given I login as "6P" "Abcd.1234"
   And user "B55446P" is ordering a DL using driver data:
        | state      | California     | 
        |ordertype   | DL             |
        |producttype |CA DL 3Y Instant|	
        |purpose     |Insurance       |		
        | lastname   | MADELIENEQA    |  
       #| firstname  | JERRYQA        |  
	   #| middlename | mid            | 
       #|billcode    | 10             |  	   
        |   dln      | D1111111       |  
       #|    dob     |01/12/1985      |
		|statecode   |CA              |
        | misc       | MVR_CA_ARCHIVE_REPOR |  
       #| gender     | Male           |  
	    |resultflag  |Status: VALID  |
	   
    When I place the DL order 
    Then I should see the DL order on "Archive Reports" page
	Then I should verify the full dl report in popup under "Archived Reports" page
    Then I logout
    
    @view-archive-report-nb-driver
Scenario: View driver in Archive Report Page
    Given I login as "6P" "Abcd.1234"
   And user "B55446P" is ordering a DL using driver data:
        | state      | New Brunswick     | 
        |ordertype   | DL             |
        |producttype |New Brunswick Online 3Y|	
        |purpose     |Insurance       |		
        #| lastname   | NBTESTQA    |  
       #| firstname  | JERRYQA        |  
	   #| middlename | mid            | 
       #|billcode    | 10             |  	   
        |   dln      | 1085813       |  
        |    dob     |01/12/1985      |
		|statecode   |CA              |
        | misc       | MVR_NB_ARCHIVE_REPOR  |  
       #| gender     | Male           |  
	    |resultflag  |Status: VALID  |
	   
    When I place the DL order 
    Then I should see the DL order on "Archive Reports" page
	Then I should verify the full dl report in popup under "Archived Reports" page
    Then I logout

 @delete-driver-from-archived-reports
Scenario Outline: Delete driver from Archived Reports
   Given I login as "6P" "Abcd.1234"
   Given drivers with data "<state>","<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>","<misc>" and "<orderstatus>" is ready for search
    And user "B55446P" is deleting a DL using driver data:
        | statecode     | CA          |  
        | lastname  | MADELIENEQA |  
        |ordertype   | DL         | 
        | dln        | D1111111   |   
    When I delete the driver from the Archive Reports page
    Then the driver should be removed from the Archive Reports page
    Then I logout
Examples: Dl orders to be deleted
|state|statecode|ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|orderstatus|
| California |CA|DL|CA DL 3Y Instant|Insurance|D1111111 |MADELIENEQA ||||||MADELIENEQA|Archived| 
   