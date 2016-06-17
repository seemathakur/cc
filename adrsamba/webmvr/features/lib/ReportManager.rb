
module ReportManager
	extend Capybara::DSL
   $pendingreport=0
	def self.submit_add_driver(formData)
	     select(formData['state'], :from => 'ddComboState')
	    select(formData['ordertype'], :from => 'OrderTypeCombo')
		select(formData['producttype'], :from => 'ProductTypeCombo') 
		select(formData['purpose'], :from => 'purposeCode')
		
		if formData.has_key?("dln")
		find(:xpath, "//input[@name='license']").set formData['dln'] 
		end
		
		if formData.has_key?("lastname") 
		find(:xpath, "//input[@name='lastName']").set formData['lastname'] 
		end
		if formData.has_key?("misc") 
		 find(:xpath, "//input[@name='misc']").set formData['misc'] 
		end
		if formData.has_key?("firstname") 
		find(:xpath, "//input[@name='firstName']").set formData['firstname'] 
		end
		
		if formData.has_key?("middlename") 
		find(:xpath, "//input[@name='middleName']").set formData['middlename'] 
		end
		
		if formData.has_key?("dob") 
		find(:xpath, "//input[@name='dob']").set formData['dob'] 
		end
		
        if formData.has_key?("billcode") 
		find(:xpath, "//input[@name='billNumber']").set formData['billcode'] 
		end		
        if formData.has_key?("gender") 		
			if formData['gender']=='Male'	
	        page.find(:xpath, '//input[@value="M"]').set(true)
	        else
	        page.find(:xpath, '//input[@value="F"]').set(true)
            end
		end 
		#click on submit  
		find(:xpath,"//input[@name='submitData']",wait:3).click
		#for duplicate order click on yes
		if page.has_content?('Duplicate Orders')
	     	find(:xpath,"//input[@name='yes']").click
		end
				

	end
     def self.checkdlorder_added?(pagetitle,dln,statecode,misc)
     page.has_title?(pagetitle)
     page.find(:xpath,"//table[@align='left']//tr[ (td[4]='#{dln}') and (td[6]='#{statecode}')  and (td[9][normalize-space(text()='#{misc}')])]")
     end
	
	def self.dlorder_added?(pagetitle,formData)

		page.has_title?(pagetitle)
		lastName = formData['lastname']
		firstName = formData['firstname']
		#middleName = formData['middlename']
		dln = formData['dln']
		dob = formData['dob']
		state = formData['state']
		stateCode=formData['statecode']
		misc = formData['misc']
		#gender = formData['gender']
        #billCode = formData['billcode']
		orderType = formData['ordertype']
		productType = formData['producttype']
		purpose=formData['purpose']
		
		orderdate= Date.today.strftime("%m/%d/%Y")
           puts orderdate
        
		orderdesc=""
        if (orderType=='DL' and productType=='\wInstant')
		orderdesc="Online"
		else
		orderdesc="Overnight"
		end
		
		
		# Match the form data against these fields on the unread report page
		
		page.find(:xpath,"//table[@align='left']//tr[(td[3]/a[normalize-space(text()='#{lastName}')] and td[4]='#{dln}') and (td[5]='#{orderdate}' and td[6]='#{stateCode}' and td[7][normalize-space(text()='#{orderType}')] and td[9][normalize-space(text()='#{misc}')])]")
		
		#//table[@align='left']//tr[(td[3]/a[normalize-space(text()='MADELIENEQA')] and td[4]='D1111111') and (td[5]='07/21/2015' and td[6]='CA' and td[7][normalize-space(text()='DL')] and td[8]='Online' and td[9][normalize-space(text()='MV_CA_ARCHIVE_REPOR')])]
		
		
		

	end
	
	def self.refresh_new_unread_order
	
	find(:xpath,"//input[@name='refreshbutt']").click
	sleep 5
	find(:xpath,"//input[@name='refreshbutt']").click
	#sleep 5
	#find(:xpath,"//input[@name='refreshbutt']").click
	
	end
	
	def self.select_ordertype_for_view(ordertype)
	find(:xpath,"//select[@name='reportType']/option[@value='#{ordertype}']").click
	end
    
    def self.select_ordertype_to_view(formData)
	orderType = formData['ordertype']
	find(:xpath,"//select[@name='reportType']/option[@value='#{orderType}']").click
	end
    
    def self.check_dlorder_added_in_popup?(dln,lastname)
    page.first(:xpath,"//table[@align='left']//tr[(td[3]/a[normalize-space(text()='#{lastname}')] and td[4]='#{dln}') ]/td/a").click
    
    end
	def self.open_dlorder_added_in_popup?(formData)
	  if $pendingreport!=1
	   lastName = formData['lastname']
	   dln = formData['dln']
	   page.first(:xpath,"//table[@align='left']//tr[(td[3]/a[normalize-space(text()='#{lastName}')] and td[4]='#{dln}') ]/td/a").click
	   else
	   puts "Report is still pending....."
	  end
	end
	
	
	def self.verify_DL_report_in_popup(title,formData)
	   if $pendingreport!=1
	  dln = formData['dln']
	  misc = formData['misc']
	  validation=formData['resultflag']
	  main=PopUpReport.openpopup(title)
	  popup=PopUpReport.openpopup("DRIVER'S LICENSE REPORT")
	      
	   page.within_window(popup) do
        page.has_content?('American Driving Records')
	    page.has_content?(misc)
	    page.has_content?(validation)
		  end
	   page.driver.browser.switch_to.window(main)
	   
	   else
	     puts "Report is still pending....."
	   end
 
	end
	
    def self.check_order_exists(pagetitle)
	page.has_title?(pagetitle)
     flag=NoMatchFound.no_match_found
	 puts "check_order_exists"
	 puts flag
	
	    if flag=="noreportexists" 
	    return :noReportExists
	    else 
	    return :reportExists
	     end
     end
    def self.verify_pending_order(formData,pagetitle)
	 page.has_title?(pagetitle)	
	 orderType=formData['ordertype']
	 dln = formData['dln']
	 stateCode=formData['statecode']
     misc = formData['misc']
	 orderdate= Date.today.strftime("%m/%d/%Y")
	 page.find(:xpath,"//table[@align='left']//tr[(td[4]='#{dln}') and (td[5]='#{orderdate}')and (td[6]='#{stateCode}')and  (td[9][normalize-space(text()='#{misc}')] ) and (td[10]='In Process')]")
	 $pendingreport=1
	 return :dLOrderIsStillOnPendingReportsPage
	       
	 
	   
    end

	
    def self.pending_report_wait
	
	$pendingreport=1
	
	end
	

	

	
       #----------------------#
       #####VR order ##########
       #----------------------#
	
	def self.submit_order_vr(formData)
	    select(formData['state'], :from => 'ddComboState')
	    select(formData['ordertype'], :from => 'OrderTypeCombo')
		select(formData['producttype'], :from => 'ProductTypeCombo') 
		select(formData['purpose'], :from => 'purposeCode')
		
		if formData.has_key?("vin")
		find(:xpath, "//input[@name='vin']").set formData['vin'] 
		end
		
		if formData.has_key?("plate") 
		find(:xpath, "//input[@name='plate']").set formData['plate'] 
		end
		if formData.has_key?("misc") 
		 find(:xpath, "//input[@name='misc']").set formData['misc'] 
		end
		if formData.has_key?("asofdate") 
		find(:xpath, "//input[@name='asOfDate']").set formData['asofdate'] 
		end
		
		if formData.has_key?("billcode") 
		find(:xpath, "//input[@name='billNumber']").set formData['billcode'] 
		end
		        
         
		#click on submit  
		find(:xpath,"//input[@name='submitData']",wait:3).click
		#for duplicate order click on yes
		if page.has_content?('Duplicate Orders')
	     	find(:xpath,"//input[@name='yes']").click
		end
				

	end
     def self.checkVRorder_added?(pagetitle,vin,plate,orderType,statecode,misc)
     page.has_title?(pagetitle)
     page.first(:xpath,"//table[@align='left']//tr[(td[2][normalize-space(text()='#{vin}')] ) and (td[3][normalize-space(text()='#{plate}')] )  and (td[6][normalize-space(text()='#{orderType}')] )  and (td[8][normalize-space(text()='#{misc}')])]")
     end
	def self.vrorder_added?(pagetitle,formData)

		page.has_title?(pagetitle)
		vin = formData['vin']
		plate = formData['plate']
		
		
		#asOfDate = formData['asofdate']
		state = formData['state']
		stateCode=formData['statecode']
		misc = formData['misc']
		
        #billCode = formData['billcode']
		orderType = formData['ordertype']
		productType = formData['producttype']
		purpose=formData['purpose']
		
		orderdate= Date.today.strftime("%m/%d/%Y")
          
        
		
		
		# Match the form data against these fields on the unread report page
		#//table[@align='left']/tbody//tr[(td[5]='04/02/2015')and (td[7]='Online') and (td[8]='VR_FL_VIN_SYSTEM_DOW') and (td[2]='VINNUM ')]
		page.first(:xpath,"//table[@align='left']//tr[(td[2][normalize-space(text()='#{vin}')] ) and (td[3][normalize-space(text()='#{plate}')] ) and (td[5]='#{orderdate}')  and (td[6][normalize-space(text()='#{orderType}')] )  and (td[8][normalize-space(text()='#{misc}')])]")
				

	end
    
    
	def self.check_VRorder_added_in_popup?(stateCode,vin,plate,orderType,misc)
    page.first(:xpath,"//table[@align='left']//tr[(td[2][normalize-space(text()='#{vin}')] ) and (td[3][normalize-space(text()='#{plate}')] ) and (td[6][normalize-space(text()='#{orderType}')] )  and (td[8][normalize-space(text()='#{misc}')])]/td/a").click
    end
    
    
	def self.open_vrorder_added_in_popup?(formData) 
	vin = formData['vin']
	plate = formData['plate']
		state = formData['state']
		stateCode=formData['statecode']
		misc = formData['misc']
		
        #billCode = formData['billcode']
		orderType = formData['ordertype']
		productType = formData['producttype']
		purpose=formData['purpose']
		
		orderdate= Date.today.strftime("%m/%d/%Y")
          
        
	#page.find(:xpath,"//table[@align='left']//tr[(td[3]/a[normalize-space(text()='#{lastName}')] and td[4]='#{dln}' and td[9][normalize-space(text()='#{misc}')])]/td/a").click
	
	page.first(:xpath,"//table[@align='left']//tr[(td[2][normalize-space(text()='#{vin}')] ) and (td[3][normalize-space(text()='#{plate}')] ) and (td[5]='#{orderdate}')  and (td[6][normalize-space(text()='#{orderType}')] )  and (td[8][normalize-space(text()='#{misc}')])]/td/a").click
	end

	
	
	def self.verify_VR_report_in_popup(title,formData)
	plate = formData['plate']
	vin = formData['vin']
	misc = formData['misc']
	validation=formData['resultflag']
	   main=PopUpReport.openpopup(title)
	   popup=PopUpReport.openpopup("VEHICLE REPORT")
	   
	   
	   page.within_window(popup) do
       page.has_content?('American Driving Records')
	   page.has_content?(misc)
	   page.has_content?(validation)
	  	  
       end
	   page.driver.browser.switch_to.window(main)
	end
	
	#***********************Delete DL**********#
    def self.record_number_check
    number= page.find(:xpath,"//table[@align='left' and  @width='100%']/tbody/tr/td[contains(text(),'of')]").text.to_s
       #puts number
       #index=number.length-9
       totaldrivers=number[-9,1]
       puts totaldrivers
       return :totaldrivers
       end
       
    def self.select_driver_from_page(id)
		#check("id_#{id}")
       
       page.first(:xpath,"//input[@value[contains(.,'#{id}')]]").set(true)

	end
    
    
    def self.select_delete_driver
		
       page.find(:xpath,"//input[@name='deletebutt']").click

	end
    
    def self.confirm_ok_delete_popup
		
       page.driver.browser.switch_to.alert.accept
	end
    
	def self.delete_driver_from_page(id)
       self.record_number_check
       # puts beforedel
		self.select_driver_from_page(id)
		self.select_delete_driver
		#sleep 30
		self.confirm_ok_delete_popup
	end

	def self.check_record_deleted
    self.record_number_check
		#toDO CONFIRM NUMBER NOW IS 1 LESS .
	end
    #***********************Delete DL**********#
    #***********************Upload DL Batch*************************************************#
   
    
	def self.upload_drivers(filename)
    #fail "fail here for batch"
    
    ###window specific..ToDo need long time solution
        upload_file = "#{Dir.pwd}/features/support/upload/#{filename}".gsub('/', '\\')
        #upload_file=File.join(Dir.pwd,"features","support","upload",filename)
        puts "*****************#{upload_file}******************"
       # puts "***********#{filename}*******************"
        #puts "***********#{@upload_filename}*******************"
        
        #page.attach_file('FileUpload', "C:\\webmvr\\features\\support\\upload\\BatchUploadDLTemplate.xls", visible: false)
         page.attach_file('FileUpload', upload_file, visible: false)
        click_button('Upload')
        
	end

	def self.is_expected_upload_status?(total_records, submitted_records)
		return page.has_content?("Your batch contains a total of #{total_records} record(s), #{submitted_records} of these records have been successfully submitted for processing.")
	end
    
     def self.verify_upload_error
             
        if page.has_content?("File for upload does not contain any order record or it has empty record after column header or values for mandatory fields VERSION,TYPE and PRODUCT are missing.Please correct and upload.")
        puts("###########Version,Type,Product error############")
        end
         if page.has_content?("record(s) contains errors.To correct and resubmit")    
       verify_different_batch_errors     
         end
     
     ##@orders=String.new(page.find(:xpath,"//form[@name='ShowInvalidRec']").text)
     #puts @orders
    ## @indexnum= @order.index('h')
    # puts "**************#{@indexnum}********"
     #@submitted_orders=str[@indexnum.to_i].to_i
     #puts "*************#{@submitted_orders}*******************"
     end
     
     def self.verify_different_batch_errors
     
      click_batch_error_link
      verify_possible_errors   
      delete_selected_orders
     end
     
     def self.click_batch_error_link
     page.find(:xpath,"//a[@class='batch']").click
     end
     
     def self.verify_possible_errors
     page.has_title?("Invalid records in Batch")
     if page.has_content?("Product does not exist in Database.")
     puts("#########state,subproductERROR############")
     end
     
     if page.has_content?("Purpose Code is mandatory.")
     puts("###########purposeCode Error######################")
     end
    
     if page.has_content?("First Name is mandatory.")
     puts("###################FirstName Error#########################")
     end
     
    if  page.has_content?("Last Name is mandatory.")
    puts("############Last Name Error############")
    end
     
     if page.has_content?("License less than the length specified of ")
     puts("##########LIC-Error################")
     end
     
     if page.has_content?("DATE OF BIRTH field is Invalid")
     puts("###########DOB Error#####################")
     end
     
     if page.has_content?("Either VIN or Plate is mandatory")
     puts("###########VIN or PLATE Error#####################")
     end
     end
     
     def self.delete_selected_orders
     page.find(:xpath,"//input[@name='DeleteErrorOrder']").set true
     page.find(:xpath,"//input[@name='delete']").click
     end
     #***********************Upload DL Batch****************************************************#
     
     #****************Search Reports***********************#
     def self.select_order_link_from_page(id)
		#check("id_#{id}")
       
       page.first(:xpath,"//a[@href[contains(.,'#{id}')]]").click

	end
    
    def self.open_unread_VRorder_in_popup?(order_number_data)
    select_order_link_from_page(order_number_data)
    end
end

