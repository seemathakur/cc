Feature: Search Orders



@login @search-dl-order-type 
Scenario Outline: Search orders by DL type
Given drivers with data "<state>","<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>","<misc>" and "<orderstatus>" is ready for search
Given I am on search page
Then I search "<orderstatus>" orders by order type "<ordertype>"
Then I verify search results by order type "<ordertype>"
Examples: Dl orders for search

|state|statecode|ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|orderstatus|
| California |CA|DL|CA DL 3Y Instant|Insurance|D3964249 |QA-UNREAD-CA||||||QA_UNREAD_CA|Unread| 
| California |CA|DL|CA DL 3Y Instant|Insurance|A7420755 |QA-ARCHIVE-CA ||||||QA_ARCHIVE_CA|Archived| 
| California |CA|DL|CA DL 3Y Overnight|Insurance|B7319999 |QA-PENDING-CA ||||||QA_PENDING_CA|Pending| 



@login @search-vr-order-type 
Scenario Outline: Search orders by VR type
Given VR with data "<state>","<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>","<plate>","<misc>" and "<orderstatus>" is ready for search
Given I am on search page
Then I search "<orderstatus>" orders by order type "<ordertype>"
Then I verify VR search results by order type "<ordertype>"
Examples: VR orders for search

|state|statecode|ordertype|producttype|purpose|vin|plate|misc|orderstatus|
| California |CA|VR|CA Instant Veh Current History|Insurance|1GBJP37W1G3333333||QA_UNREAD_CAVIN|Unread| 
| New York   |NY|VR|NY Instant Veh Current History|Insurance|2C4GP44L13R300000|DAJ1111|QA_UNREAD_NYPLATE|Unread| 
| Florida    |FL|VR|FL Overnight Veh Current History|Insurance|1G6KD54YX4U134414||QA_PENDING_FLVIN|Pending| 
| California |CA|VR|CA Instant Veh Current History|Insurance||1BBB111|QA_ARCHIVE_CAPLATE|Archived| 


@login @search-batch-dl-orders 
Scenario:  Search DL batch orders 
    Given dln "B1111116" ,state "CA" ,misc "BATCHDLO" is ready for batch upload
    Given dln "B1111117" ,state "CA" ,misc "BATCHDLT" is ready for batch upload 
	Given I am uploading excel file "BatchDLSearchTemplate.xls" having "2" records
    And the file contains drivers:
    |version|type|state|product|subproduct|purpose|reference  |firstname  |middlename   |lastname    |dlnum   |dateofbirth  |billcode|
    |v2.0   |AO  |CA   |DL     |3Y        |AA     |BATCHDLO   |BATCHDLO   |             |BATCHDLO    |B1111116|             |        |
    |v2.0   |AO  |CA   |DL     |3Y        |AA     |BATCHDLT   |BATCHDLT   |             |BATCHDLT    |B1111117|             |        |
	When I upload the excel file
    Then I search uploaded batch
    #Then the drivers get uploaded