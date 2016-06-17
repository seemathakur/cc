Feature: Batch Uploading

# All scenarios use Before and After hooks to perform login/logout
# See features/support/hooks.rb for details of available tags. 


@batch-upload-dl @login
Scenario: Upload Batch DL excel file
    Given dln "T1111111" ,state "CA" ,misc "SEARCHDLCA" is ready for batch upload
    Given dln "T1111112" ,state "CA" ,misc "SEARCHCADL" is ready for batch upload 
	Given I am uploading excel file "BatchUploadDLTemplate.xls" having "2" records
	When I upload the excel file
	Then the file is uploaded
   
@batch-upload-vr @login
Scenario: Upload Batch VR excel file
    Given VR for state "CA" ,misc "VIN_QA_BATCH" is ready for batch upload
    Given VR for state "CA" ,misc "PLATE_QA_BATCH" is ready for batch upload
	Given I am uploading excel file "BatchUploadVRTemplate.xls" having "2" records
	When I upload the excel file
	Then the file is uploaded
    
    
@batch-upload-invalid-dl @login
Scenario: Upload Invalid Batch DL excel file
	Given I am uploading excel file "BatchErrorDLTemplate.xls" having "1" records
	When I upload the excel file
	Then I verify batch upload error 
    
    
@batch-upload-invalid-vr @login
Scenario: Upload Invalid Batch VR excel file
	Given I am uploading excel file "BatchErrorVRTemplate.xls" having "2" records
	When I upload the excel file
	Then I verify batch upload error 
    
 @batch-upload-pw @login
Scenario: Upload Batch PW excel file
    Given dln "D2599999" ,state "CA" ,misc "PWSEARCH" is ready for batch upload
    Given dln "U1111111" ,state "CA" ,misc "SEARCHPW" is ready for batch upload 
	Given I am uploading excel file "BatchUploadPWTemplate.xls" having "2" records
	When I upload the excel file
	Then the file is uploaded
       
 @batch-upload-sr @login
Scenario: Upload Batch SR excel file
    Given dln "L1111111" ,state "CA" ,misc "SRCPO" is ready for batch upload
    Given dln "A1111111" ,state "CA" ,misc "SRCPT" is ready for batch upload 
    Given dln "E9986118" ,state "CA" ,misc "SRCPTH" is ready for batch upload 
	Given I am uploading excel file "BatchUploadSRTemplate-CProducts.xls" having "3" records
	When I upload the excel file
	Then the file is uploaded
             