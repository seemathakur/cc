Feature: Order VR from WebMVR

Background:
   Given VR "CA", "1GBJP37W1G3333333", "" ,"VR_CA_VIN_HITO" is ready to be ordered  
   Given VR "CA", "2T1BR32E08C111111", "" ,"VR_CA_VIN_HITT" is ready to be ordered 
   Given VR "CA", "", "9ZZZ123" ,"VR_CA_PLATE_NO_HIT" is ready to be ordered 
   
	#Given VR "NY", "5TDBT48A03S188888", "" ,"VR_NY_VIN_HIT" is ready to be ordered   
   #Given VR "NY", "1FDWE3OS3XHB67104", "" ,"VR_NY_VIN_SYSTEM_DOW" is ready to be ordered 
   #Given VR "NY", "", "DAJ1111" ,"VR_NY_PLATE_HIT" is ready to be ordered 
   
   
   	
	#Given VR "FL", "1G6KD54YX4U134414", "" ,"VR_FL_VIN_HIT" is ready to be ordered   
   #Given VR "FL", "VINNUM", "" ,"VR_FL_VIN_SYSTEM_DOW" is ready to be ordered 
   #Given VR "FL", "", "VDV99K" ,"VR_FL_PLATE_HIT" is ready to be ordered 
   
    #Given VR "TX", "1GCGC13U42F143429", "" ,"VR_TX_VIN_HIT" is ready to be ordered   
   #Given VR "TX", "WP0CA29914S650540", "" ,"VR_CA_VIN_HITT" is ready to be ordered 
   #Given VR "TX", "", "BBB111" ,"VR_CA_PLATE_NO_HIT" is ready to be ordered  
   
@order-vrs-ol-ca @login
Scenario Outline: Order CA VRs with various vehicle data
Given I am ordering an VR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>", "<plate>" and reference "<misc>"
    When I submit my VR order request 
    Then I should see a confirmation message
   Examples: CA VRs with vin or plate
    |statecode| ordertype|producttype|purpose|vin|plate|misc|
    
	| California |VR|CA Instant Veh Current History|Insurance|1GBJP37W1G3333333 ||VR_CA_VIN_HITO| 
	
	| California |VR|CA Instant Veh Current History|Insurance||9ZZZ123|VR_CA_PLATE_NO_HIT| 
	
	
@order-vrs-ao-ca @login
Scenario Outline: Order CA VRs with various vehicle data
Given I am ordering an VR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>", "<plate>" and reference "<misc>"
    When I submit my VR order request 
    Then I should see a confirmation message
   Examples: CA VRs with vin or plate
    |statecode| ordertype|producttype|purpose|vin|plate|misc|   
	| California |VR|CA Overnight Veh Current History|Insurance|2T1BR32E08C111111 ||VR_CA_VIN_HITT| 	
	

	@order-vrs-ol-ny @login
Scenario Outline: Order NY VRs with various vehicle data
Given I am ordering an VR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>", "<plate>" and reference "<misc>"
    When I submit my VR order request 
    Then I should see a confirmation message
   Examples: NY VRs with vin or plate
    |statecode|ordertype|producttype|purpose|vin|plate|misc|
    #process down first record#
	| New York |VR|NY Instant Veh Current History|Insurance|5TDBT48A03S188888 |EBX7777|VR_NY_VIN_HIT|
    | New York |VR|NY Instant Veh Current History|Insurance|1FDWE3OS3XHB67104||VR_NY_VIN_SYSTEM_DOW| 
	| New York |VR|NY Instant Veh Current History|Insurance|2C4GP44L13R300000|DAJ1111|VR_NY_PLATE_HIT| 
	
	
@order-vrs-ao-ny @login
Scenario Outline: Order NY VRs with various vehicle data
Given I am ordering an VR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>", "<plate>" and reference "<misc>"
    When I submit my VR order request 
    Then I should see a confirmation message
   Examples: NY VRs with vin or plate
    |statecode| ordertype|producttype|purpose|vin|plate|misc|
	| New York |VR|NY Overnight Veh Current History|Insurance|5TDBT48A03S188888 |EBX7777|VR_NY_VIN_HIT| 
 
	
	@order-vrs-ol-fl @login
Scenario Outline: Order FL VRs with various vehicle data
Given I am ordering an VR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>", "<plate>" and reference "<misc>"
    When I submit my VR order request 
    Then I should see a confirmation message
   Examples: FL VRs with vin or plate
    |statecode| ordertype|producttype|purpose|vin|plate|misc|
    | Florida |VR|FL Instant Veh Current History|Insurance|1G6KD54YX4U134414 ||VR_FL_VIN_HIT| 
	| Florida |VR|FL Instant Veh Current History|Insurance|VINNUM||VR_FL_VIN_SYSTEM_DOWN| 
	| Florida |VR|FL Instant Veh Current History|Insurance||VDV99K|VR_FL_PLATE_HIT| 
	
@order-vrs-ao-fl @login
Scenario Outline: Order FL VRs with various vehicle data
Given I am ordering an VR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>", "<plate>" and reference "<misc>"
    When I submit my VR order request 
    Then I should see a confirmation message
   Examples: NY VRs with vin or plate
    |statecode| ordertype|producttype|purpose|vin|plate|misc|
    | Florida |VR|FL Overnight Veh Current History|Insurance|1G6KD54YX4U134414 ||VR_FL_VIN_HIT| 
	
	
	
  @order-vrs-ol-tx @login
Scenario Outline: Order TX VRs with various vehicle data
Given I am ordering an VR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>", "<plate>" and reference "<misc>"
    When I submit my VR order request 
    Then I should see a confirmation message
   Examples: TX VRs with vin or plate
    |statecode| ordertype|producttype|purpose|vin|plate|misc|
    | Texas |VR|TX Instant Veh Current History|Insurance|1GCGC13U42F143429||VR_TX_VIN_HIT| 
    | Texas |VR|TX Instant Veh Current History|Insurance|WP0CA29914S650540||VR_TX_SYSTEM_DOWN|	
    | Texas |VR|TX Instant Veh Current History|Insurance||BBB111|VR_TX_HIT BY PLATE|	

   @order-vrs-ao-tx @login
Scenario Outline: Order TX VRs with various vehicle data
Given I am ordering an VR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<vin>", "<plate>" and reference "<misc>"
    When I submit my VR order request 
    Then I should see a confirmation message
   Examples: TX VRs with vin or plate
    |statecode| ordertype|producttype|purpose|vin|plate|misc|
    | Texas |VR|TX Overnight Veh Current History|Insurance|1GCGC13U42F143429||VR_TX_VIN_HIT| 
   
  