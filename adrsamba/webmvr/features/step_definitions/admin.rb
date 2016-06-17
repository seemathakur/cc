Given (/^status is activated for userid "(.*?)"$/) do |usernameid|

users=TblUsername.where("UserNameID = ?", usernameid)
    users.each do|u|
		u.update(Status:"A")  
        end
     mvruser= TblUserinfo.where("UserId =?",'B554424')  
     mvruser.each do|u|
		u.update(Type:"Standard")  
        end
 end

Given (/^status is suspended for userid "(.*?)"$/) do |usernameid|
uid=0
users=TblUsername.where("UserNameID = ?", usernameid)
    users.each do|u|
		u.update(Status:"S")  
                    
	end
    
    mvruser= TblUserinfo.where("UserId =?",'B554485')
    mvruser.each do|u|
		u.update(Type:"Standard")  
        end
end
Given (/^user "(.*?)", "(.*?)", "(.*?)" ,"(.*?)" ,"(.*?)","(.*?)" is ready to be reset$/) do|usernameid,status,mvruserid,usertype,email,defpassword|
users=TblUsername.where("UserNameID = ?", usernameid)
    users.each do|u|
		u.update(Status: status) 
        u.update(Email: email)    
        u.update(DefPwd: defpassword)
        end
     mvruser= TblUserinfo.where("UserId =?",mvruserid)  
     mvruser.each do|mu|
     
    
         #puts mu['Type']
         #puts mu['EmailId']
		mu.update(Type:usertype) 
        mu.update(EmailId: email)    
             
        end
end



Given(/^I am on the admin page$/) do
	Admin.goto_admin_page
end


When(/^I click on Account Management link$/) do
   Admin.click_account_management_link
end

When (/^I set status "(.*?)" for user "(.*?)"$/) do|userstatus,username|

	Admin.set_user_status(userstatus,username)
end

Then (/^the user "(.*?)" should be "(.*?)"$/) do |username,userstatus|
    #Admin.click_back_button
   Admin.verify_status(username,userstatus)
end

When (/^I set type "(.*?)" for user "(.*?)"$/) do|usertype,username|
Admin.set_userType(usertype,username)
end
Then (/^the user "(.*?)" should be of type "(.*?)"$/) do|username,usertype|
Admin.verify_usertype(username,usertype)
end

When (/^I set email "(.*?)" for user "(.*?)"$/) do|email,username|
Admin.set_email_for_user(email,username)
end

Then (/^the user "(.*?)" should have email "(.*?)"$/) do|username,email|
Admin.verify_userEmail(username,email)
end

When (/^I add new user with credentials as "(.*?)","(.*?)" and "(.*?)"$/) do|firstname,lastname,email|
Admin.click_addUser_button
Admin.add_new_user(firstname,lastname,email)

end


Then(/^verify self registration message$/)do
Admin.verify_self_registration_message
end

When (/^I select user "(.*?)" to delete under account "(.*?)"$/)do|username,acct|
Admin.delete_user(username,acct)
ReportManager.confirm_ok_delete_popup
Admin.verify_deletion_message
end

Then (/^the user "(.*?)" should deleted$/)do
Admin.verify_status(username,userstatus)

end

When (/^I set department "(.*?)" for user "(.*?)"$/)do|deptt,username|
Admin.assign_user_department(deptt,username)
ReportManager.confirm_ok_delete_popup

end
Then (/^I verify department update message$/)do
Admin.verify_deptt_update_message

end

Then (/I set default password "(.*?)" ,"(.*?)" and "(.*?)" for user "(.*?)","(.*?)"$/)do|dpassword,pin,email,username,usernameid|
Admin.set_default_password(dpassword,pin,email,username,usernameid)
end

 Then (/^I verify profile update message$/)do
 Admin.verify_profile_update_message
 end
 
Then (/^I verify empty pin alert$/)do
 Admin.verify_error_alert
 end
 Then (/^I fill pin "(.*?)" and submit$/)do|pin|
Admin.set_pin(pin)
Admin.submit_password_button
 end
 
 Then(/^I click on Set Default Password link$/) do
   Admin.click_default_password_link
   
end
Then (/^I submit empty request$/) do
 expect(true).to be_truthy
Admin.submit_password_button
end

Then (/^I verify empty password alert$/) do
Admin.verify_error_alert
end

Then (/^I fill default password "(.*?)" and submit$/) do|pwd|
Admin.set_password(pwd)
Admin.submit_password_button

end
 Then (/^I verify incorrect password alert$/) do
 Admin.verify_error_alert
 end
 
 Then (/^I verify empty email alert$/) do
  Admin.verify_error_alert
 end
 
 Then (/^I fill email "(.*?)" and submit$/) do|email|
 Admin.set_email(email) 
 Admin.submit_password_button
 end
 
 Then (/^I verify incorrect email alert$/) do
 Admin.verify_error_alert
 end
  
  Then(/^I update requestor code  for account "(.*?)",state "(.*?)",agreement "(.*?)" and expiration date$/) do|acct,state,agrment|  
  
  expdate=Admin.set_date
  Admin.update_requestor_code(acct,state,agrment,expdate)
 end
 Then (/^I verify dmv request code succeess message$/) do 
 
 Admin.verify_dmv_request_code_success_message
 end
 
 Then (/^I verify dmv request code error message$/) do 
 Admin.verify_dmv_request_code_error_message
   end
   
   
Given (/^I am on manage department page$/) do 
Admin.goto_department_page
end  

Then (/^I add new department "(.*?)"$/) do |deptt|
Admin.add_new_department(deptt)
Admin.click_add_dept_button
end
Then(/^I verify "([^"]*)" department added to existing list$/) do |deptt|
Admin.verify_deptt_added(deptt)
end

Then (/^I rename old "(.*?)" to new "(.*?)" department name$/) do |olddept,newdept|
Admin.change_dept_name(olddept,newdept)
end

Then (/^I select department "(.*?)" to be deleted$/) do |deptt|
Admin.add_new_department(deptt)
Admin.click_add_dept_button
Admin.select_department_to_delete(deptt)
end
Then (/^the department "(.*?)" is deleted$/) do|deptt|
Admin.dept_deleted(deptt)
end

When (/^I select user "(.*?)" with status "(.*?)" to be activated$/)do |username,oldstatus|
Admin.activate_user(username,oldstatus)
end

Then (/^user "(.*?)" is activated as "(.*?)"$/)do |username,newstatus|
Admin.verify_status(username,newstatus)
end