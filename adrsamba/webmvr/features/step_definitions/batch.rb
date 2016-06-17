


Given (/^dln "(.*?)" ,state "(.*?)" ,misc "(.*?)" is ready for batch upload$/) do|dln,statecode,misc|
@dln= dln
 @stateCode = statecode
 @misc=misc
Search.batch_data_cleanup(@stateCode,@dln)
end


Given (/^VR for state "(.*?)" ,misc "(.*?)" is ready for batch upload$/) do|statecode,misc|
 @stateCode = statecode
 @misc=misc
  Search.cleanup_vr_data(@stateCode,@misc)
end

Then( /^the list should contain the uploaded drivers$/) do
    @drivers_in_upload_file.each do |driver|
        ListManager.driver_table_open_full_profile(driver)
        ListManager.full_profile_matches?(driver)
        ListManager.full_profile_return_to_previous_page
    end
end

Given (/^I am uploading excel file "(.*?)" having "(.*?)" records$/) do |filename,recnum|
MainMenu.select_menu_item("Batch Upload (Excel)")

@upload_filename = filename
@recordnum=recnum


end

When (/^I upload the excel file$/) do
ReportManager.upload_drivers(@upload_filename)
end
	
Then (/^the file is uploaded$/) do
ReportManager.is_expected_upload_status?(@recordnum, @recordnum)
end
    
Then (/^I verify batch upload error$/) do
ReportManager.verify_upload_error
end 