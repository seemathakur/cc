

module OrderMvr
	extend Capybara::DSL
	
	# Assumes you are on the home page
	def self.navigate_to_new_order
    	click_on('New Order')
	end
	
	def self.select_state(stateCode)
    	select(stateCode, :from => 'ddComboState')
        #expect(page).to have_text(stateCode, wait: 3)
	end
	def self.select_ordertype(orderType)
    select(orderType, :from => 'OrderTypeCombo')
   # expect(page).to have_text(orderType, wait: 3)
	end
	
	def self.select_product(productType)
    select(productType, :from => 'ProductTypeCombo') 
    #expect(page).to have_text(productType, wait: 3)
	end
	
	def self.select_purpose(pp)
	select(pp, :from => 'purposeCode')
	
	end

     def self.submit_order
	find(:xpath,"//input[@name='submitData']").click
	end
    
	def self.submit_dl_order(stateCode, orderType,productType,pp,dln,lastName, firstName,midName, dob, gender,ssn, misc)
		navigate_to_new_order
		select_state(stateCode)
		select_ordertype(orderType)
		select_product(productType)
		select_purpose(pp)
		
		if dln.present? 
		find(:xpath, "//input[@name='license']").set dln
		end		
		if lastName.present? 
		find(:xpath, "//input[@name='lastName']").set lastName
		end		
		if firstName.present? 
		find(:xpath, "//input[@name='firstName']").set firstName
		end		
		if midName.present? 
		find(:xpath, "//input[@name='middleName']").set midName
		end		
		if dob.present? 
		find(:xpath, "//input[@name='dob']").set dob
		end		
		if ssn.present?
		 find(:xpath, "//input[@name='ssn']").set ssn
		end		
        if gender.present? 		
			select_gender(gender)
		end		
		if misc.present?
		 find(:xpath, "//input[@name='misc']").set misc
		end
		
		#$adding sleep for GA
		if stateCode=='Georgia'
		 sleep 3
		 submit_order
		 else
		 submit_order
		 end
		if mvr_order_empty?
			return :incomplete_order_exists
		elsif is_lastname_empty?
			return :lastname_missing
		elsif is_license_empty?
			return :license_missing
		elsif is_order_complete?
			return :order_submitted
		else
			find(:xpath,"//input[@name='yes']",wait: 3).click
			return :order_submitted			
		end
	    #if is_order_displayed?
        	#return :order_submitted
          #  return true
		#elsif is_duplicate_order?
			#find(:xpath,"//input[@name='yes']",wait: 3).click
			#return :order_submitted	
            #return true	
		#else 
		#sleep 20
        #return false
        #end
	end
    
	def self.is_duplicate_order?
    page.has_content?("Duplicate Orders")
    end
    
	def self.mvr_order_empty?
		page.has_content?("License is mandatory.")
		page.has_content?("Last Name is mandatory.")
	end
	
	def self.is_lastname_empty?
		page.has_content?("Last Name is mandatory.")
	end
    
    def self.is_order_displayed?
		page.has_content?("American Driving Records")
	end
    
    def self.is_order_delayed?
    
    page.find(:xpath,"img[@id='spinner']")
    end    
	def self.is_license_empty?
		page.has_content?("License is mandatory.")
	end
	
	def self.vr_order_empty?
		page.has_content?("VIN or Plate required.")
	end
	
	def self.vr_order_incorrect?
		page.has_content?("Wrong VIN.orPlate required.")
	end
	
	def self.is_order_complete?
		page.has_content?("ORDER SAVED and SUBMITTED.")
	end
    
	def self.select_gender(gender)
	if gender=='Male'	
	page.find(:xpath, '//input[@value="M"]').set(true)
	else
	page.find(:xpath, '//input[@value="F"]').set(true)
     end
	end
	
	def self.order_confirmed?
	   page.has_content?('ORDER SAVED and SUBMITTED')
	   page.has_content?('Verify Your Order in Unread Reports')
	  	   
		
	end
    
    def self.get_order_number(orderstatus,statecode,dln)
    uid=0
    test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	test_user.each do|u|
     uid = u['UserId']
	end
    
         if orderstatus=='Unread'
           dl_mvrs=Tblorderdl.where("LicenseNumber=? and State=? and  OnlineUser= ?",dln,statecode,uid)
         elsif orderstatus=='Pending'
           dl_mvrs=TblOrderao.where("LicenseNumber=? and State=? and  OnlineUser= ?",dln,statecode,uid)
         else
           dl_mvrs=TblArchiveoldl.where("LicenseNumber=? and State=? and  OnlineUser= ?",dln,statecode,uid)
	     end	
    
    dl_mvrs.each do|mvr|
	        @order_number=mvr['OrderNumber']
            end
            #puts "%%%%%%%%%%%%%%%%%%%%%#{@order_number}%%%%%%%%%%%%%%"
    return @order_number
    end
  def self.submit_vr_order(stateCode, orderType,productType,purpose,vin,plate,misc)
		navigate_to_new_order
		select_state(stateCode)
		select_ordertype(orderType)
		select_product(productType)
		select_purpose(purpose)
		
		if vin.present? 
		fill_in('vin', :with => vin)
		end
		
		if plate.present? 
		fill_in('plate', :with => plate)
		end
		
			
		
		if misc.present?
		 find(:xpath, "//input[@name='misc']").set misc
		end
		 
		
		submit_order
		
		if vr_order_empty?
			return :incomplete_VR_order_exists
		elsif vr_order_incorrect?
			return :incorrectVinOrPlate
		elsif is_order_complete?
			return :order_submitted
		else
			find(:xpath,"//input[@name='yes']",wait: 3).click
			return :order_submitted			
		end
		return :order_submitted	
	end
 
    def self.get_vr_order_number(orderstatus,statecode,misc)
    uid=0
    test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	test_user.each do|u|
     uid = u['UserId']
	end
    
         if orderstatus=='Unread'|| orderstatus=='Pending'
        vr_mvrs=Tblordervr.where("State=? and  OnlineUser= ? and Misc=?",statecode,uid,misc)
         
         else
           vr_mvrs=TblArchivevr.where("State=? and  OnlineUser= ? and Misc=?",statecode,uid,misc)
	     end	
    
     vr_mvrs.each do|mvr|
	        @order_number=mvr['OrderNumber']
            end
            #puts "%%%%%%%%%%%%%%%%%%%%%#{@order_number}%%%%%%%%%%%%%%"
    return @order_number
    end
 
	def self.verify_online_delay_message
     sleep 100
     page.has_content?("There has been a processing delay. Please check the Unread Reports in a few minutes.") 
    end
    
	def self.verify_report(dln,misc)
        
           page.has_content?(dln)
           page.has_content?(misc)         
         
        
   end
end