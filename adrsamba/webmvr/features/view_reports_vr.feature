Feature: VR Reports View

# All scenarios use Before and After hooks to perform login/logout
# See features/support/hooks.rb for details of available tags.
 
   @view-unread-report-ca-vr-vin
Scenario: View vehicle registration in Unread Report Page for order by vin
    Given I login as "6P" "Abcd.1234"
    And user "B55446P" is ordering VR by vin:
	       
		| state      | California     | 
        |ordertype   | VR             |
        |producttype |CA Instant Veh Current History|	
        |purpose     |Insurance       |		
        | vin        | 2T1KU40E39C129644 |  
       #| plate      | 1BBB111         |  
	   #| asofdate   |   12/12/2014    | 
       #|billcode    | 10              |  	   
        |statecode   |CA               |
        | misc       | VR_CA_REPORT_VIN    |  
        |resultflag  |Vehicle Section     |
		
	   
    When I place the VR order 
    Then I should see the VR order on "Unread Reports" page
	Then I should verify the full vr report in popup under "Unread Reports" page
    Then I logout
 @view-archive-report-ca-vr_vin
Scenario: View vehicle registration in Archive Report Page
    Given I login as "6P" "Abcd.1234"
    And user "B55446P" is ordering VR by vin:
        | state      | California     | 
        |ordertype   | VR             |
        |producttype |CA Instant Veh Current History|	
        |purpose     |Insurance       |		
        | vin        | 4T1BE32KX5U090909 |  
        #| plate      | 1BBB111         |  
	   #| asofdate   |   12/12/2014    | 
       #|billcode    | 10              |  	   
        |statecode   |CA               |
        | misc       | VR_CA_REPORT_VIN |  
        |resultflag  |Vehicle Section   |
	   
    When I place the VR order 
    Then I should see the VR order on "Archive Reports" page
	Then I should verify the full vr report in popup under "Archived Reports" page
    Then I logout
@view-unread-report-ca-vr-plate
Scenario: View vehicle registration in Unread Report Page for order by vin
    Given I login as "6P" "Abcd.1234"
    And user "B55446P" is ordering VR by plate:
	       
		| state      | California     | 
        |ordertype   | VR             |
        |producttype |CA Instant Veh Current History|	
        |purpose     |Insurance       |		
        #| vin        | 2T1KU40E39C129644|  
        | plate      | 21386A1         |  
	   #| asofdate   |   12/12/2014    | 
       #|billcode    | 10              |  	   
        |statecode   |CA               |
        | misc       | VR_CA_REPORT_PLATE    |  
        |resultflag  |Vehicle Section     |
		
	   
    When I place the VR order 
    Then I should see the VR order on "Unread Reports" page
	Then I should verify the full vr report in popup under "Unread Reports" page
    Then I logout
	
@view-archive-report-ca-vr_plate
Scenario: View vehicle registration in Archive Report Page
    Given I login as "6P" "Abcd.1234"
    And user "B55446P" is ordering VR by plate:
        | state      | California     | 
        |ordertype   | VR             |
        |producttype |CA Instant Veh Current History|	
        |purpose     |Insurance       |		
        #| vin        | 4T1BE32KX5U090909 |  
        | plate      | 1BBB111         |  
	   #| asofdate   |   12/12/2014    | 
       #|billcode    | 10              |  	   
        |statecode   |CA               |
        | misc       | VR_CA_REPORT_PLATE |  
        |resultflag  |Vehicle Section   |
	   
    When I place the VR order 
    Then I should see the VR order on "Archive Reports" page
	Then I should verify the full vr report in popup under "Archived Reports" page
    Then I logout
   
   

   
   


       
      