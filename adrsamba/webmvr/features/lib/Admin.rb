module Admin
	extend Capybara::DSL

	def self.goto_admin_page
    click_account_management_link
	click_user_management_link
    
	end

	
def self.set_user_status(userstatus,username)
		user_name_search(username)
		edit_user(username)
        select_status(userstatus)
        update_status
        verify_update_message
        click_back_button
	end
	
    def self.click_manage_deptt_link
    click_link('Manage Departments')
    page.has_content?("Add Department")
    end
    
    def self.click_account_management_link
    click_link('Account Management')
    page.has_content?(" Manage all of your account parameters.")
    end
    
    
    def self.click_default_password_link
    click_link('Set Default Password')
    page.has_content?("Set Default Password")
    end
    
    def self.click_user_management_link
    click_link('User Management')
    page.has_title?("User Access Management")
    end
    
    def self.user_name_search(username)  
    page.find(:xpath, "//input[@name='wildCardSearch']").set username
    page.find(:xpath, "//input[@name='get']").click
    
   end 
     def self.click_update_requestor_code_link
    click_link('Update Requester Code')
    page.has_content?("DMV Requester Code Details")
    end
  def self.edit_user(username)  
    click_link('Edit')
    page.has_content?('QA2 TESTER')
    
   end 
   
   
   def self.set_date
    date=Datehelper.get_today_date
    newdate=(date+1).strftime("%m%d%Y")
    return newdate
   end
   
  def self.select_status(userstatus)
    	select(userstatus, :from => 'userStatus')
        
	end
   
    def self.update_status
     page.find(:xpath, "//input[@name='updtBtn']").click	
        
	end
    def self.click_back_button
     page.find(:xpath, "//input[@name='backBtn']").click	
        
	end 
  
    def self.verify_update_message
    page.has_content?('Update is Successful')
        
	end
    
    def self.verify_user_status_details(username,userstatus)  
    page.first(:xpath,"//table[@class='ListTable']//tr[(td[4][normalize-space(text()='#{username}')]) and (td[7][normalize-space(text()='#{userstatus}')])]")
        
	end
    def self. verify_status(username,userstatus)
    
    user_name_search(username)  
    verify_user_status_details(username,userstatus)    
	end
    
    def self.select_usertype(usertype)
    	select(usertype, :from => 'userType')
        
	end
     
    def self.set_userType(usertype,username)
		user_name_search(username)
		edit_user(username)
        select_usertype(usertype)
        update_status
        verify_update_message
	end
    
	def self.verify_usertype(username,usertype) 
    click_back_button
    user_name_search(username)  
        
    page.first(:xpath,"//table[@class='ListTable']//tr[(td[4][normalize-space(text()='#{username}')]) and (td[9][normalize-space(text()='#{usertype}')])]")
        
	end

    def self.set_email_for_user(email,username)
		user_name_search(username)
		edit_user(username)
        set_user_email(email)
        update_status
        verify_update_message
	end
    
    def self.set_user_email(email)
    	page.find(:xpath, "//input[@name='emailId']").set email
	end
    
    def self.verify_userEmail(username,email)
    click_back_button
    user_name_search(username)  
        
    page.first(:xpath,"//table[@class='ListTable']//tr[(td[4][normalize-space(text()='#{username}')]) and (td[6][normalize-space(text()='#{email}')])]")
        
	end
  
    def self.click_addUser_button
    page.find(:xpath,"//input[@name='addUser']").click
     #click_on('addUser')        
	end 
    
    
  def self.add_new_user(firstname,lastname,email)
    page.has_content?("Request to Add User")
    page.find(:xpath,"//input[@name='txtFirstName']").set firstname
    page.find(:xpath,"//input[@name='txtLastName']").set lastname
    page.find(:xpath,"//input[@name='txtEmail']").set email
    page.find(:xpath,"//input[@name='submitButton' and @value='GO']").click
    #click_on("submitButton")
  end
   
   
   def self.verify_self_registration_message
   page.has_content?("  Request to Add User ")
   page.has_content?(" The User you have entered has been sent an email")
   page.has_content?("  with instructions to self register. 				ADR will approve")
   page.has_content?(" the request when the user completes the self")
   page.has_content?("registration process.")
   
   end
   def self.select_user_to_delete(account,username)
  # page.find(:xpath,"//input[@name='deleteMe']").set true
   page.first(:xpath,"//input[@value[contains(.,'B55441B')]]").set(true)
 
   page.find(:xpath,"//input[@name='deleteBtn1']").click
   end
   
   
   def self.delete_user(username,acct)
   #user_name_search(username)
   
   select_user_to_delete(username,acct)
   end
   
   def self.verify_deletion_message
   page.has_content?("User(s) Status is Deleted Successfully ")
   
   end
   
   def self.assign_user_department(deptt,username)
   user_name_search(username)
   page.find(:xpath,"//input[@name='deleteMe']").set true
   select_department(deptt) 
   page.find(:xpath,"//input[@name='assignDeptBtn']").click
   end
   
   def self.select_department(deptt)
    	select(deptt, :from => 'assignDept')
        
	end
    
   def self.verify_deptt_update_message
   page.has_content?("B554424 successfully updated to Department NEW TEST DEPT ")
   
   end
   
   def self.set_default_password(dpassword,pin,email,username,usernameid)
   click_default_password_link
   verify_user_info_from_dbtable(usernameid)
   submit_default_password_request(dpassword,pin,email)
   end
   def self.verify_user_info_from_dbtable(usernameid)
     users=TblUsername.where("UserNameID = ?", usernameid)
     users.each do|u|
		@uname=u['UserName']
        @lastname=u['LastName']
        @dlstate=u['LicSt']
        
        end
        #puts("b5544#{@uname}")
        #puts(@uname)
        #puts(@lastname)
        #puts(@dlstate)
        page.has_content?("b5544#{@uname}") 
         page.has_content?(@lastname)
        page.has_content?(@dlstate)
        
     
   end
   
   def self.set_pin(pin)
   page.find(:xpath,"//input[@name='pin']").set pin
   end
   
   def self.set_password(pwd)
   page.find(:xpath,"//input[@name='Default']").set pwd
   end
   def self.set_email(email)
   page.find(:xpath,"//input[@name='Email']").set email
   end
   def self.submit_password_button
   click_button("Go")
   end
   
   def self.submit_default_password_request(dpassword,pin,email)   
   set_pin(pin) 
  set_password(dpassword)   
   set_email(email)
   submit_password_button   
   end
   
   def self.verify_profile_update_message
   page.has_content?("Profile updated successfully")
   end
   
   def self.verify_error_alert
  
  # page.driver.browser.switch_to.alert.accept
  text=page.driver.browser.switch_to.alert.text
  # puts alert.text
  #@atext=alert.text
  puts text
  #expect(text).to eq 'Please enter PIN'
  page.driver.browser.switch_to.alert.accept
  
   #expect(true).to be_truthy
   #expect(alert.text).to eq t('Please enter PIN')
   
   #page.browser.browser.switch_to.alert.accept
   end
  
  def self.select_state_request(state)
    select(state, :from => 'state')
   
	end
  def self.fill_agreement(agrment)
  page.find(:xpath,"//input[@name='AgrNumber']").set agrment
  end
  def self.set_expiration_date(expdate)
  page.find(:xpath,"//input[@name='ExpDate']").set expdate
  end
  def self.submit_request_code_button
  page.find(:xpath,"//input[@name='submitButton']").click
  end
  def self.update_requestor_code(acct,state,agrment,expdate)
  click_update_requestor_code_link
  select_state_request(state)
  fill_agreement(agrment)
  set_expiration_date(expdate)
  submit_request_code_button
  end
  def self.verify_dmv_request_code_success_message
   page.has_content?("DMV Requester Code Details")
    page.has_content?("FAST HELP")
      page.has_content?("California Clients: ADR will send E-Mail notification to your ADR Account Administrator, starting 90 days prior to your Requester Code expiration date. To use, please enter your current DMV Agreement/  Account number and expiration. This information can be found on your Commercial	Requester Account Approval Letter provided by the California DMV. If you need any other help with your Requester Code, please contact your ADR Representative")
      page.has_content?("Successfully Updated") 
  end
   
   
   def self.verify_dmv_request_code_error_message
   page.has_content?("DMV Requester Code Details")
    page.has_content?("FAST HELP")
      page.has_content?("California Clients: ADR will send E-Mail notification to your ADR Account Administrator, starting 90 days prior to your Requester Code expiration date. To use, please enter your current DMV Agreement/  Account number and expiration. This information can be found on your Commercial	Requester Account Approval Letter provided by the California DMV. If you need any other help with your Requester Code, please contact your ADR Representative")
      page.has_content?("Your Agreement Number does not match ADR records") 
  end
   
   def self.goto_department_page
    click_account_management_link
    click_manage_deptt_link
    
   end
   
   
   def self.add_new_department(deptt)
   fill_in('deptName', :with => deptt)
   end
   
   def self.click_add_dept_button
    find(:xpath,"//input[@name='addDept']").click
   end
   
   def self.click_del_dept_button
    find(:xpath,"//input[@name='deleteDept']").click
   end
   
    def self.verify_deptt_added(deptt)
      select_existing_deptt(deptt)
      page.has_content?(deptt)
      #expect(page).to eq(deptt)
      #expect(page).to have_select('renExistingDept', selected: deptt)
    end
    
    def self.change_dept_name(olddept,newdept)
    select_existing_deptt(olddept)
    rename_to_dept_name(newdept)
    end
    
    def self.select_existing_deptt(deptt)
    select(deptt, :from => 'renExistingDept') 
    #expect(true).to be_truthy    
       
	end
    
    
    def self.rename_to_dept_name(newdept)
    find(:xpath, "//input[@name='newDeptName']").set newdept
    find(:xpath, "//input[@name='renameDept']").click
    end
    
    def self.select_department_to_delete(deptt)
    select(deptt, :from => 'delExistingDept') 
    click_del_dept_button
    end
    
    def self.dept_deleted(deptt)
    page.has_no_content?(deptt)
    end
    
    def self.select_user_to_activate
     page.find(:xpath,"//input[@name='deleteMe']").set(true)
    end
    def self.click_activate_button
    page.find(:xpath,"//input[@name='activateAll']").click
    end
    def self.accept_popup_msg
    page.driver.browser.switch_to.alert.accept
    end
    def self.activate_user(username,oldstatus)
      user_name_search(username)
      select_user_to_activate
      click_activate_button
      accept_popup_msg
    end
end