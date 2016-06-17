
module Login 
	extend Capybara::DSL
	#@@tempPassword=null
	def self.login(url, username, password)
	    visit url
		#sleep 5
		if page.has_field?('accountID')
		fill_in 'accountID',:with => 'B5544'
		fill_in 'UserId', :with => username
		fill_in 'Pwd', :with => password 
	    click_button('goBtn')
		else
		fill_in 'UserId', :with => username
		fill_in 'Pwd', :with => password 
	    click_button('goBtn')
		end
	    
	end

	def self.logout
		click_on("Logout")
	end

	
	def self.logged_in?
		page.has_title?('New Order Page')
	    
		page.has_xpath?("//a[normalize-space(text()='Logout')]")
	end
	
    def self.not_logged_in?
	page.has_title?('WebADR Login Page')
	page.has_content?('Invalid password. Try again.')
			
	end
	
	def self.on_main_login_page?
		
			page.has_xpath?("//td[normalize-space(text()='Welcome to WebADR Login Page')]", wait: 5)
		
	end
	
	def self.change_password_fill(username,password1,password2,acct)
		fill_in 'accountID',:with => acct
		fill_in 'UserId', :with => username
		fill_in 'PrPassword', :with => password1 
		fill_in 'NewPassword', :with => password2 
		fill_in 'ReNewPassword', :with => password2 
        accept_adr_terms_conditions
	    click_button('goBtn')
	end
	
	def self.verify_success_message?
		
			page.has_content?("Your password has been successfully changed.Re-login to enter the site.")
		
	end
	
	def self.change_password_link		
	page.find(:xpath, "//a[@href='MvrChangePasswordPage.jsp']").click		
	end
	
	def self.forgot_password_link	
	page.find(:xpath, "//a[@href='ForgotPassword.jsp?fromPage=webmvr']").click
	end
	
	def self.technical_support_page	
	page.has_content?("Please contact Technical Support at")
	page.has_content?("800-777-6655")
	page.has_content?("For further Password Assistance")
	end
    
	def self.accept_adr_terms_conditions
    check('chbConditions')
    end
    
	def self.security_questions_link	
	page.find(:xpath, "//a[@href='MvrForgotPasswordUserDetail.jsp']").click
	end
	
	def self.log_in( acct,username, password)
		
		if page.has_field?('accountID')
		fill_in 'accountID',:with => acct
		fill_in 'UserId', :with => username
		fill_in 'Pwd', :with => password 
	    click_button('goBtn')
		else
		fill_in 'UserId', :with => username
		fill_in 'Pwd', :with => password 
	    click_button('goBtn')
		end
		
	end
	
	
	def self.forgot_password_fill(acct,username)
	    page.has_title?("Forgotten or Expired Password")
		fill_in 'accountID',:with => acct
		fill_in 'UserId', :with => username
       
		click_button('goBtn')
	end
	
	def self.answer_security_question_one	
	
	forgot_password_fill("B5544","6Q")
	page.has_content?("What is your Mother's maiden name?")
	page.find(:xpath, "//input[@name='answer']").set "kailash"
	click_button('goBtn')
	temporary_password=page.first(:xpath,"//b").text
	
	puts temporary_password
	page.find(:xpath,"//a[@href='MvrWebLogin.jsp']").click
	log_in("B5544","6Q",temporary_password)
	
	end
	
	def self.answer_security_question_two	
	
	forgot_password_fill("B5544","6Q")
	page.has_content?("What is your Mother's maiden name?")
	page.find(:xpath, "//input[@name='answer']").set "kailashs"
	click_button('goBtn')
	
	page.has_content?("In what City were you born?")
	page.find(:xpath, "//input[@name='answer']").set "hoshiarpur"
	click_button('goBtn')
	
	temporary_password=page.first(:xpath,"//b").text
	
	puts temporary_password
	page.find(:xpath,"//a[@href='MvrWebLogin.jsp']").click
	log_in("B5544","6Q",temporary_password)
	
	end
	
	def self.change_password_only_fill(newpassword)
		page.has_title?("Change Password")
		fill_in 'NewPassword', :with => newpassword 
		fill_in 'ReNewPassword', :with => newpassword 
       accept_adr_terms_conditions
	    click_button('goBtn')
	end
	
	def self.answer_security_questions_incorrect	
	
	forgot_password_fill("B5544","6Q")
	page.has_content?("What is your Mother's maiden name?")
	page.find(:xpath, "//input[@name='answer']").set "kailashs"
	click_button('goBtn')
	
	page.has_content?("In what City were you born?")
	page.find(:xpath, "//input[@name='answer']").set "hoshiarpurs"
	click_button('goBtn')
			
	end
	
	def self.clear_inbox
		
		# viewpoint code
		endpoint = 'https://webmail.onlinepcm.com/ews/exchange.asmx'
		user = 'qatester2@adtscore.net'
		pass = 'W3lc0m3%94'

		cli = Viewpoint::EWSClient.new endpoint, user, pass

		# pp inbox = cli.get_folder 'Inbox'
		# inbox = Viewpoint::EWS::Folder.get_folder_by_name('Inbox')
		inbox = cli.get_folder_by_name('Inbox')

		# This just goes through the inbox in order. We may need to clear out
		# the emails in a background task.
		items = inbox.items
		if items.size > 0
			item_ids_to_delete = items.collect { |wi| {:item_id => {:id => wi.id } } }
			cli.ews.delete_item(delete_type: 'HardDelete', send_meeting_cancellations: 'SendToNone', item_ids: item_ids_to_delete)
		end

	end
	
	def self.forgot_password
		visit WMVR_URL
       Login.forgot_password_link
	end
   def self.submit_request_new_password(acct,user,email)
		    page.has_title?("Forgotten or Expired Password")
			fill_in 'AccNo', :with => acct
			fill_in 'Uid', :with => user
			fill_in 'email', :with => email
			click_button('goBtn')
		
	end
	def self.verify_email_message?
	page.has_content?(" Please check your email for instructions on how to change your password.")
	end
	
	def self.click_temporary_password_link_from_email
		
		

		# viewpoint code
		endpoint = 'https://webmail.onlinepcm.com/ews/exchange.asmx'
		user = 'qatester2@adtscore.net'
		pass = 'W3lc0m3%94'

		cli = Viewpoint::EWSClient.new endpoint, user, pass

		# pp inbox = cli.get_folder 'Inbox'
		# inbox = Viewpoint::EWS::Folder.get_folder_by_name('Inbox')
		inbox = cli.get_folder_by_name('Inbox')

		# This just goes through the inbox in order. We may need to clear out
		# the emails in a background task.
		items = inbox.items
		items.each do |current_item|
		    if "Steps to reset password" == current_item.subject
		        # puts current_item.body
		        #page.first(:xpath,"//a").click
		    end
		end
	end
    
    def self.dismiss_alert
		page.driver.browser.switch_to.alert.accept
	end
    
    def self.error_maximum_login_attempts
    page.has_content?(" You have exceeded the maximum number of login attempts.")
    page.has_content?("  to issue a temporary password.")
    end
    
end