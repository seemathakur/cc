Given (/^the password is reset for userid "(.*?)"$/) do |usernameid|
uid=0
users=TblUsername.where("UserNameID = ?", usernameid)
    users.each do|u|
	pwd=u['CurPwd']
	u.update(CurPwd:"5def5d7bs6e4bfdf71d5d5a1e9971fa4")  
	u.update(Pwd01:'NULL')
	u.update(Pwd01ActDate:'NULL')
	u.update(Pwd01DctDate:'NULL')
	u.update(FailCount:0)
	u.update(SecurityQuestionFailCount:0)
	u.update(TempIssueDate:'NULL')
    u.update(TempPwd:'NULL')
   # u.update(Status:"A")
   #user.update(Status:"S")
   #user.update(Email:"")
    #userid=TblUserinfo.find(J500130)
     #if not userid.nil?
  #userid.update(Type:"Standard")
#end
	end

end
Given (/^I login for account "(.*?)" user "(.*?)" and password "(.*?)"$/)do|acct,username,password|
visit WMVR_URL
Login.log_in(acct,username, password)
end
Then (/^I am logged in$/)do
 
    #assert_equal(true, Login.logged_in?)
	 Login.logged_in?
end
Then (/^I am not logged in$/)do
#Login.dismiss_alert
Login.not_logged_in?
end
# Use to explicitly login with specified credentials.
# This step should only be used by scenarios tagged with @nologin
# otherwise the hooks automatically perform login/logout
Given (/^I login as "(.*?)" "(.*?)"$/) do |username, password|
	
	Login.login(WMVR_URL, username, password)
end

# Use to explicitly logout 
# otherwise the hooks automatically perform login/logout
Then (/^I logout$/) do
	Login.logout
end
When (/^I request for change password$/)do
visit WMVR_URL
Login.change_password_link
#page.find(:xpath, "//a[@href='MvrChangePasswordPage.jsp']").click

end
When (/^I request for security questions$/)do 
visit WMVR_URL
Login.forgot_password_link
Login.security_questions_link
end

Then (/^I answer security question one correctly$/)do
Login.answer_security_question_one
end
Then (/^I answer security question one incorrectly$/)do
Login.answer_security_question_two
end
Then (/^I change password "(.*?)"$/)do|pwd|
Login.change_password_only_fill(pwd)
end
Then (/^I login as user "(.*?)",old password "(.*?)" and the new password "(.*?)" for account "(.*?)"$/)do|user, pass1,pass2,acct|
Login.change_password_fill(user, pass1,pass2,acct)
end
Then (/^I verify password change success message$/)do
Login.verify_success_message?
end

Then (/^I re-login as "(.*?)","(.*?)" and "(.*?)"$/)do|acct,username, password|
Login.log_in(acct,username, password)
end
Then (/^I answer security questions incorrectly$/)do
Login.answer_security_questions_incorrect
end

Then (/^verify I am on Technical Support page$/)do
Login.technical_support_page	
end

Given (/^I forgot my password$/) do
	Login.clear_inbox
	Login.forgot_password
end
When (/^I request a new password for account "(.*?)",user "(.*?)" and email "(.*?)"$/)do|acct,user,email|

	Login.submit_request_new_password(acct,user,email)
end

Then (/^I should receive a temporary password via email$/) do
	sleep 5
	Login.click_temporary_password_link_from_email
	

end

Then (/^I verify password change by email message$/) do
Login.verify_email_message?
visit WMVR_URL
Login.change_password_link

end


Then (/^I am locked out$/) do
Login.error_maximum_login_attempts

end