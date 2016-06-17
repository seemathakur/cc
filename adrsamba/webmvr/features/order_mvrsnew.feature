
Feature: Order MVR from WebMVR
Background:
 Given driver "CA", "B4444444", "QAMVRCADLNO" ,"MVR_CA_HIT" is ready to be ordered
   Given driver "CA", "E1111111", "QAMVRCADLNT" ,"MVR_CA_HITT" is ready to be ordered
   Given driver "CA", "D9985104", "QAMVRCADLNTH" ,"MVR_CA_DIRTY_HIT" is ready to be ordered----report on right
   Given driver "CA", "D6666666", "QAMVRCADLNF" ,"MVR_CA_SYSTEM_DOWN" is ready to be ordered
   
Given driver "GA", "888888888", "QAMVRGADLNO" ,"MVR_GA_HIT" is ready to be ordered
   Given driver "GA", "028708853", "QAMVRGADLNT" ,"MVR_GA_HITT" is ready to be ordered
   Given driver "GA", "041187462", "QAMVRGADLNTH" ,"MVR_GA_NO_HIT" is ready to be ordered
	
    Given driver "FL", "B111111111111", "" ,"MVR_FL_HIT" is ready to be ordered
	Given driver "FL", "C333333333333", "" ,"MVR_FL_NO_HIT" is ready to be ordered
	
	Given driver "NY", "877338399", "QAMVRNYDLNO" ,"MVR_NY_HIT" is ready to be ordered
	Given driver "NY", "777777777", "QAMVRNYDLNT" ,"MVR_NY_HITT" is ready to be ordered
	Given driver "NY", "299683649", "QAMVRNYDLNTH" ,"MVR_NY_NO_HIT" is ready to be ordered

   Given driver "NJ", "A12345678901234", "QAMVRNJDLNO" ,"MVR_NJ_HIT" is ready to be ordered
   Given driver "NJ", "V99900011122200", "QAMVRNJDLNT" ,"MVR_NJ_DIRTY_HIT" is ready to be ordered
   Given driver "NJ", "M12345678901234", "QAMVRNJDLNTH" ,"MVR_NJ_SYSTEM_DOWN" is ready to be ordered
   Given driver "NJ", "X22233344455566", "QAMVRNJDLNF" ,"MVR_NJ_NO_HIT" is ready to be ordered

   Given driver "IL", "P66666666666", "QAMVRILDLNO" ,"MVR_IL_HIT" is ready to be ordered
   Given driver "IL", "C11111111111", "QAMVRILDLNT" ,"MVR_IL_HITT" is ready to be ordered
   Given driver "IL", "R11122233344", "QAMVRILDLNTH" ,"MVR_IL_DIRTY_HIT" is ready to be ordered
   Given driver "IL", "M23092761212", "QAMVRILDLNF" ,"MVR_IL_NO_HIT" is ready to be ordered


   
    Given driver "PA", "11111115", "QAMVRPADLNO" ,"MVR_PA_HIT" is ready to be ordered
	Given driver "PA", "66666662", "QAMVRPADLNT" ,"MVR_PA_SYSTEM_DOWN" is ready to be ordered
	Given driver "PA", "11111111", "QAMVRPADLNTH" ,"MVR_PA_NO_HIT" is ready to be ordered

    Given driver "TX", "11111111", "QAMVRTXDLNO" ,"MVR_TX_HIT" is ready to be ordered
	Given driver "TX", "66666666", "QAMVRTXDLNT" ,"MVR_TX_SYSTEM_DOWN" is ready to be ordered
	Given driver "TX", "33333333", "QAMVRTXDLNTH" ,"MVR_TX_NO_HIT" is ready to be ordered
   
    Given driver "OH", "BB122111 ", "QAMVROHDLNO" ,"MVR_OH_HIT" is ready to be ordered
	Given driver "OH", "BB122112 ", "QAMVROHDLNT" ,"MVR_OH_DIRTY_HIT" is ready to be ordered
	Given driver "OH", "DD666666", "QAMVROHDLNTH" ,"MVR_OH_SYSTEM_DOWN" is ready to be ordered


	
   
   
@order-mvrs-ol-ca @login
Scenario Outline: Order CA MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: CA drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | California |DL|CA DL 3Y Instant|Insurance|B4444444 |QAMVRCADLNO ||||||MVR_CA_HIT| 
	#| California |DL|CA DL 3Y Instant|Insurance|E1111111 |QAMVRCADLNT ||||||MVR_CA_HITT|	
    #| California |DL|CA DL 3Y Instant|Insurance|D9985104 |QAMVRCADLNTH||||||MVR_CA_DIRTY_HIT |	
	#| California |DL|CA DL 3Y Instant|Insurance|D6666666 |QAMVRCADLNF ||||||MVR_CA_SYSTEM_DOWN|
	
@order-mvrs-ao-ca @login
Scenario Outline: Order CA MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
    Examples: CA drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
   # | California |DL|CA DL 3Y Overnight|Insurance|B4444444 |QAMVRCADLNO ||||||MVR_CA_HIT| 
    | California |DL|CA DL 3Y Overnight|Insurance|E1111111 |QAMVRCADLNT ||||||MVR_CA_HITT|	
    #| California |DL|CA DL 3Y Overnight|Insurance|D9985104 |QAMVRCADLNTH||||||MVR_CA_DIRTY_HIT |	
	#| California |DL|CA DL 3Y Overnight|Insurance|D6666666 |QAMVRCADLNF ||||||MVR_CA_SYSTEM_DOWN|          
@order-mvrs-ol-ny @login
Scenario Outline: Order NY MVRs with various driver data 
 Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
    Examples: NY drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | New York |DL|NY DL 3Y Instant|Insurance|877338399 |QAMVRNYDLNO ||||||MVR_NY_HIT| 
    | New York |DL|NY DL 3Y Instant|Insurance|777777777 |QAMVRNYDLNT ||||||MVR_NY_HITT|	
	| New York |DL|NY DL 3Y Instant|Insurance|299683649 |QAMVRNYDLNTH||||||MVR_NY_NO_HIT|	time exceeded message
@order-mvrs-ao-ny @login
Scenario Outline: Order NY MVRs with various driver data  
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
    Examples: NY drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | New York |DL|NY DL 3Y Overnight|Insurance|877338399 |QAMVRNYDLNO |QAMVRNYDLNO|||||MVR_NY_HIT| 
   | New York |DL|NY DL 3Y Overnight|Insurance|777777777 |QAMVRNYDLNT |QAMVRNYDLNT|||||MVR_NY_HITT|	
	| New York |DL|NY DL 3Y Overnight|Insurance|299683649 |QAMVRNYDLNTH |QAMVRNYDLNTH|||||MVR_NY_NO_HIT|	
	
@order-mvrs-ol-fl @login
Scenario Outline: Order FL MVRs with various driver data   
 Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
    Examples: FL drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Florida |DL|FL DL 3Y Instant|Insurance|B111111111111 |||||||MVR_FL_HIT|    
	| Florida |DL|FL DL 3Y Instant|Insurance|C333333333333 |||||||MVR_FL_NO_HIT|	
@order-mvrs-ao-fl @login
Scenario Outline: Order FL MVRs with various driver data      
  Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
    Examples: FL drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Florida |DL|FL DL 3Y Overnight|Insurance|B111111111111 |||||||MVR_FL_HIT|    
	| Florida |DL|FL DL 3Y Overnight|Insurance|C333333333333 |||||||MVR_FL_NO_HIT|	

@order-mvrs-ol-ga @login
Scenario Outline: Order GA MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
    Examples: GA drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
   | Georgia |DL|GA DL 3Y Instant|Insurance|888888888 |QAMVRGADLNO|QAMVRGADLNO|QAMVRGADLNO|08/08/1979|Male||MVR_GA_HIT|   
    | Georgia |DL|GA DL 3Y Instant|Insurance|028708853 |QAMVRGADLNT|QAMVRGADLNT|QAMVRGADLNT|12/12/1980|Female||MVR_GA_HITT| 	
	| Georgia |DL|GA DL 3Y Instant|Insurance|041187462 |QAMVRGADLNTH|QAMVRGADLNTH|QAMVRGADLNTH|12/10/1970|Male||MVR_GA_HIT_NotNohit|	
@order-mvrs-ao-ga @login
Scenario Outline: Order GA MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
    Examples: GA drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Georgia |DL|GA DL 3Y Overnight|Insurance|888888888 |QAMVRGADLNO|QAMVRGADLNO|QAMVRGADLNO|12/12/1980|Male||MVR_GA_HIT|   
    | Georgia |DL|GA DL 3Y Overnight|Insurance|028708853 |QAMVRGADLNT|QAMVRGADLNT|QAMVRGADLNT|12/12/1990|Female||MVR_GA_HITT| 	
	| Georgia |DL|GA DL 3Y Overnight|Insurance|041187462 |QAMVRGADLNTH|QAMVRGADLNTH|QAMVRGADLNTH|12/12/1970|Male||MVR_GA_NO_HIT|	
	
@order-mvrs-ol-NJ @login
Scenario Outline: Order NJ MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: NJ drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | New Jersey |DL|NJ DL 3Y Instant|Insurance|A12345678901234|QAMVRNJDLNO ||||||MVR_NJ_HIT| 
	| New Jersey |DL|NJ DL 3Y Instant|Insurance|V99900011122200|QAMVRNJDLNT ||||||MVR_NJ_DIRTY_HIT| --report to the side print report not complete
    #| New Jersey |DL|NJ DL 3Y Instant|Insurance|M12345678901234|QAMVRNJDLNTH||||||MVR_NJ_SYSTEM_DOWN|	
    | New Jersey |DL|NJ DL 3Y Instant|Insurance|X22233344455566|QAMVRNJDLNF ||||||MVR_NJ_NO_HIT|

@order-mvrs-AO-NJ @login
Scenario Outline: Order NJ OVernight MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: NJ drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | New Jersey |DL|NJ DL 3Y Overnight|Insurance|A12345678901234|QAMVRNJDLNO|QAMVRNJDLNO|||||MVR_NJ_HIT| 
	| New Jersey |DL|NJ DL 3Y Overnight|Insurance|V99900011122200|QAMVRNJDLNT|QAMVRNJDLNT|||||MVR_NJ_DIRTY_HIT| 
    #| New Jersey |DL|NJ DL 3Y Overnight|Insurance|M12345678901234|QAMVRNJDLNTH|QAMVRNJDLNTH|||||MVR_NJ_SYSTEM_DOWN|	
    | New Jersey |DL|NJ DL 3Y Overnight|Insurance|X22233344455566|QAMVRNJDLNF|QAMVRNJDLNF|||||MVR_NJ_NO_HIT|	
	
@order-mvrs-ol-IL @login
Scenario Outline: Order IL MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: IL drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Illinois |DL|IL DL 3Y Instant|Insurance|P66666666666|QAMVRILDLNO ||||||MVR_IL_HIT| 
    | Illinois |DL|IL DL 3Y Instant|Insurance|C11111111111|QAMVRILDLNT ||||||MVR_IL_HITT|	
    | Illinois |DL|IL DL 3Y Instant|Insurance|R11122233344|QAMVRILDLNTH||||||MVR_IL_DIRTY_HIT |	
    | Illinois |DL|IL DL 3Y Instant|Insurance|M23092761212|QAMVRILDLNF ||||||MVR_IL_NO_HIT|

@order-mvrs-AO-IL @login
Scenario Outline: Order IL OVernight MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: IL drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Illinois |DL|IL DL 3Y Overnight|Insurance|P66666666666|QAMVRILDLNO||||||MVR_IL_HIT| 
    | Illinois |DL|IL DL 3Y Overnight|Insurance|C11111111111|QAMVRILDLNT||||||MVR_IL_HITT|	----prossing goes down
    | Illinois |DL|IL DL 3Y Overnight|Insurance|R11122233344|QAMVRILDLNTH||||||MVR_IL_DIRTY_HIT |	----prossing goes down
    | Illinois |DL|IL DL 3Y Overnight|Insurance|M23092761212|QAMVRILDLNF||||||MVR_IL_NO_HIT|----prossing goes down
	
@order-mvrs-ol-cdlis @login
Scenario Outline: Order CDLIS MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: CDLIS Drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | All States |DL|CDLIS|Insurance||QAMVRCDLISO|QAMVRCDLISO||11/10/1980||222202000|MVR_CDLIS_HIT| 
	| All States |DL|CDLIS|Insurance||QAMVRCDLIST|QAMVRCDLIST||11/12/1980||111111111|MVR_CDLIS_HITT| 
	| All States |DL|CDLIS|Insurance||QAMVRCDLISTH|QAMVRCDLISTH||11/09/1985||111111113|MVR_CDLIS_DIRTY_HIT| 
	| All States |DL|CDLIS|Insurance||QAMVRCDLISF|QAMVRCDLISF||12/09/1985||666666666|MVR_CDLIS_STATE_DOWN| Time out error
	
@order-mvrs-ol-PA @login
Scenario Outline: Order PA MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: PA drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Pennsylvania |DL|PA DL 3Y Instant|Insurance|11111115|QAMVRPADLNO||||||MVR_PA_HIT| 
    | Pennsylvania |DL|PA DL 3Y Instant|Insurance|66666662|QAMVRPADLNT||||||MVR_PA_SYSTEM_DOWN|	
    | Pennsylvania |DL|PA DL 3Y Instant|Insurance|11111111|QAMVRPADLNTH||||||MVR_PA_NO_HIT|

@order-mvrs-AO-PA @login
Scenario Outline: Order PA OVernight MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: PA drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Pennsylvania |DL|PA DL Employment Overnight|Insurance|11111115|QAMVRPADLNO||||||MVR_PA_HIT| 
    | Pennsylvania |DL|PA DL Employment Overnight|Insurance|66666662|QAMVRPADLNT||||||MVR_PA_SYSTEM_DOWN|	
    | Pennsylvania |DL|PA DL Employment Overnight|Insurance|11111111|QAMVRPADLNTH||||||MVR_PA_NO_HIT|
	
@order-mvrs-ol-TX @login
Scenario Outline: Order TX MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: TX drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Texas |DL|TX DL 3Y Instant|Insurance|11111111|QAMVRTXDLNO|||12/12/1970|||MVR_TX_HIT| --proess down
    | Texas |DL|TX DL 3Y Instant|Insurance|66666666|QAMVRTXDLNT|||10/11/1980|||MVR_TX_SYSTEM_DOWN|	timeout error
    | Texas |DL|TX DL 3Y Instant|Insurance|33333333|QAMVRTXDLNTH|||11/11/1990|||MVR_TX_NO_HIT|	

@order-mvrs-ao-TX @login
Scenario Outline: Order TX MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: TX drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Texas |DL|TX DL 3Y Overnight|Insurance|11111111|QAMVRTXDLNO|||12/12/1970|||MVR_TX_HIT| 
    | Texas |DL|TX DL 3Y Overnight|Insurance|66666666|QAMVRTXDLNT|||10/11/1980|||MVR_TX_SYSTEM_DOWN|	
    | Texas |DL|TX DL 3Y Overnight|Insurance|33333333|QAMVRTXDLNTH|||11/11/1990|||MVR_TX_NO_HIT|	

    
 @order-mvrs-ol-OH @login
Scenario Outline: Order OH MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: OH drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Ohio |DL|OH DL 3Y Instant|Insurance|BB122111|QAMVROHDLNO||||||MVR_OH_HIT| 
    | Ohio |DL|OH DL 3Y Instant|Insurance|BB122112|QAMVROHDLNT||||||MVR_OH_DIRTY_HIT|	
    | Ohio |DL|OH DL 3Y Instant|Insurance|DD666666|QAMVROHDLNTH||||||MVR_OH_SYSTEM_DOWN|	
    
    
     @order-mvrs-ao-OH @login
Scenario Outline: Order OH MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>","<ssn>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: OH drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|ssn|misc|
    | Ohio |DL|OH DL 3Y Overnight|Insurance|BB122111|QAMVROHDLNO|QAMVROHDLNO|||||MVR_OH_HIT| 
    | Ohio |DL|OH DL 3Y Overnight|Insurance|BB122112|QAMVROHDLNT|QAMVROHDLNT|||||MVR_OH_DIRTY_HIT|	
    
    | Ohio |DL|OH DL 3Y Overnight|Insurance|DD666666|QAMVROHDLNTH|QAMVROHDLNTH|||||MVR_OH_SYSTEM_DOWN|	
    
 @order-mvrs-ol-AL @login
Scenario Outline: Order AL MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: AL drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|misc|
    | Alabama |DL|AL DL 3Y Instant|Insurance|1111111|QAMVRALDLN|||||MVR_AL_HIT| 
    | Alabama |DL|AL DL 3Y Instant|Insurance|6666666|QAMVRALDLN||||MVR_AL_System_Down|	
    | Alabama |DL|AL DL 3Y Instant|Insurance|1114444|QAMVRALDLN||||MVR_AL_NO_HIT|

@order-mvrs-AO-AL @login
Scenario Outline: Order AL OVernight MVRs with various driver data
Given I am ordering an MVR with order data "<statecode>", "<ordertype>", "<producttype>", "<purpose>","<dln>", "<lastname>", "<firstname>","<midname>","<dob>","<gender>" and reference "<misc>"
    When I submit my DL order request 
    Then I should see a confirmation message
   Examples: AL drivers with DLN
    |statecode| ordertype|producttype|purpose|dln|lastname|firstname|midname|dob|gender|misc|
    | Alabama |DL|AL DL 3Y Overnight|Insurance|1111111|QAMVRALDLN|||||MVR_AL_HIT| 
    | Alabama |DL|AL DL 3Y Overnight|Insurance|6666666|QAMVRALDLN|||||MVR_AL_System_Down|	
    | Alabama |DL|AL DL 3Y Overnight|Insurance|1114444|QAMVRALDLN|||||MVR_AL_NO_HIT|