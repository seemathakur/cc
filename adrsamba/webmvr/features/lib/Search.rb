module Search
	extend Capybara::DSL

    def self.select_order_type(ordertype)
     select(ordertype, :from => 'ddSearchIn') 

    end
    
    
    def self.cleanup_dl_data(statecode,dln,misc)
    
    # Get user info
	uid=0
    test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	test_user.each do|u|
     uid = u['UserId']
	end
    
    # Make sure the DL isn't already ordered in OredrOlDL
   #Tblorderdl.destroy_all(OnlineUser: uid,State:  statecode ,LicenseNumber: dln ,Misc: misc )
          orderOL_mvrs=Tblorderdl.where("LicenseNumber=? and State=? and  OnlineUser= ? and Misc=?",dln,statecode,uid,misc)		
		    orderOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']		        
            TblTransoldl.destroy_all(OrderNumber: order_number)		            
		   mvr.destroy
		   end
  #deleting overnight  orders from orderAODL	
		overnightOL_mvrs=TblOrderao.where("LicenseNumber=? and State=? and  OnlineUser= ? and Misc=? ",dln, statecode,uid,misc)
		  # puts overnightOL_mvrs.length
		    overnightOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
			#TblTransaodl.delete_all(OrderNumber: order_number)
            TblTransaodl.destroy_all(OrderNumber: order_number)
	       # puts "done"
            mvr.destroy
		   end
    #deleting online archive orders from ArchiveOlDL	
	archiveOL_mvrs=TblArchiveoldl.where("LicenseNumber=? and State=? and  OnlineUser= ? and Misc=?",dln,statecode,uid,misc)
		#puts archiveOL_mvrs.length
		    archiveOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
	        #deleting orders from OLDLReadDates table dependency		
	        TblReaddates.destroy_all(OrderNumber: order_number)
            TblTransoldl.destroy_all(OrderNumber: order_number)
			#puts "done"
            
		   mvr.destroy
		   end
        
      #deleting overnight  orders from orderAODL	
		overnightOL_mvrs=TblOrderao.where("LicenseNumber=? and State=? and  OnlineUser= ? and Misc=?",dln,statecode,uid,misc)
		  # puts overnightOL_mvrs.length
		    overnightOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
			TblTransaodl.delete_all(OrderNumber: order_number)
            TblTransaodl.destroy_all(OrderNumber: order_number)
	       # puts "done"
            mvr.destroy
		   end
     #deleting overnight archive orders from ArchiveAODL	
		overnightAROL_mvrs=TblArchiveaodl.where("LicenseNumber=? and State=? and  OnlineUser= ? and Misc=?",dln,statecode,uid,misc)
		  # puts overnightAROL_mvrs.length
		    overnightAROL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
			TblAOReaddates.destroy_all(OrderNumber: order_number)
	       # puts "done"
            mvr.destroy
		
		   end	   
        
    end    

    
     def self.setup_dl_order(state,stateCode, orderType,productType,pp,dln,lastName, firstName,midName, dob, gender,ssn, misc,orderstatus)
        @search_orders = {}
      if orderstatus=='Unread' || orderstatus=='Pending'
       OrderMvr.submit_dl_order(state,orderType,productType,pp,dln,lastName, firstName,midName, dob, gender,ssn, misc)
       order_number_data=OrderMvr.get_order_number(orderstatus,stateCode,dln)
      # puts "**********************#{order_number_data}**********************"
       @search_orders[order_number_data]=[order_number_data, stateCode, dln, misc]
       else
       #puts ("Archive order")
       OrderMvr.submit_dl_order(state,orderType,productType,pp,dln,lastName, firstName,midName, dob, gender,ssn, misc)
       order_number_data=OrderMvr.get_order_number(orderstatus,stateCode,dln)
       MainMenu.select_menu_item("Pending Reports")
       MainMenu.select_menu_item("Unread Reports")
	   ReportManager.select_ordertype_for_view(orderType)
	   ReportManager.refresh_new_unread_order
       ReportManager.checkdlorder_added?("Unread Reports",dln,stateCode,misc)
       ReportManager.check_dlorder_added_in_popup?(dln,lastName)
       order_number_data=OrderMvr.get_order_number(orderstatus,stateCode,dln)
      # puts "**********************#{order_number_data}**********************"
       
       @search_orders[order_number_data]=[order_number_data, stateCode, dln, misc]
     end

    end
    
    
    def self.verify_search_data
      
    @search_orders.values.each do |record| 
     #puts "***************#{record[0]}*********#{record[1]}***#{record[2]}***#{record[3]}*********"
   
      page.first(:xpath,"//table[@class='searchData']//tr[(td[4]='#{record[0]}') and (td[8]='#{record[1]}') and (td[9]='#{record[2]}') and (td[14]='#{record[3]}')]")
    
    end
    end
    
    
    def self.verify_vr_search_data
      
    @search_vr_orders.each do |record| 
     #puts "***************#{record[0]}*********#{record[1]}***#{record[2]}***#{record[3]}*******#{record[4]}**"
     test=#{record[2]}
         if test==''
         page.first(:xpath,"//table[@class='searchData']//tr[(td[4]='#{record[0]}') and (td[8]='#{record[1]}') and (td[9]='#{record[3]}') and (td[14]='#{record[4]}')]")
         else
         page.first(:xpath,"//table[@class='searchData']//tr[(td[4]='#{record[0]}') and (td[8]='#{record[1]}') and (td[9]='#{record[2]}') and (td[14]='#{record[4]}')]")
         end
       end
    end
    
    def self.select_order_status(orderstatus)
    select(orderstatus, :from => 'tbSearchForStatus')
    end
    def self.select_order_type(ordertype)
    select(ordertype, :from => 'ddSearchIn')
    end
    def self.submit_search_button
    click_button('goBtn')
    end
    
    
    #***************************VR SEARCH ORDERS*****************************************#
    
      def self.cleanup_vr_data(statecode,misc)
      
         uid=0
         test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	
	     test_user.each do|u|
		    uid = u['UserId']
		     end
       #deleting online orders from OrderVR	
	   
       Tblordervr.destroy_all(OnlineUser: uid,State: statecode ,Misc: misc )
	   #deleting orders from archiveVR
        orderAR_vrs=TblArchivevr.where("State=? and  OnlineUser= ? and Misc=?",statecode,uid,misc)
      #puts orderAR_vrs.length
	    orderAR_vrs.each do|vr|
	    order_number=vr['OrderNumber']
	     #puts order_number
	   #deleting orders from VRreaddate table dependency		
	  TblVReaddates.destroy_all(OrderNumber: order_number)
	  #  puts "done"
          vr.destroy
	        end
      end
      
     def self.setup_vr_order(state,stateCode,orderType,productType,purpose,vin,plate,misc,orderstatus)
       @search_vr_orders = {}
      if orderstatus=='Unread' || orderstatus=='Pending'
       OrderMvr.submit_vr_order(state,orderType,productType,purpose,vin,plate, misc)
       order_number_data=OrderMvr.get_vr_order_number(orderstatus,stateCode,misc)
      # puts "**********************#{order_number_data}**********************"
       @search_vr_orders[order_number_data]=[order_number_data, stateCode, vin,plate, misc]
       else
       #puts ("Archive order")
       OrderMvr.submit_vr_order(state,orderType,productType,purpose,vin,plate,misc)
       order_number_data=OrderMvr.get_vr_order_number("Unread",stateCode,misc)
       MainMenu.select_menu_item("Pending Reports")
       MainMenu.select_menu_item("Unread Reports")
	   ReportManager.select_ordertype_for_view(orderType)
	  
       ReportManager.checkVRorder_added?("Unread Reports",vin,plate,orderType,stateCode,misc)
	 
      ReportManager.open_unread_VRorder_in_popup?(order_number_data)
       order_number_data=OrderMvr.get_vr_order_number(orderstatus,stateCode,misc)
      # puts "**********************#{order_number_data}**********************"
       
       @search_vr_orders[order_number_data]=[order_number_data, stateCode, vin,plate, misc]
     end

      end
      
      
      #***************************VR SEARCH ORDERS*****************************************#
     def self.batch_data_cleanup(statecode,dln)
      # Get user info
	uid=0
    test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	test_user.each do|u|
     uid = u['UserId']
	end
   
   #deleting overnight  orders from orderAODL	
		overnightOL_mvrs=TblOrderao.where("LicenseNumber=? and State=? and  OnlineUser= ?",dln, statecode,uid)
		  # puts overnightOL_mvrs.length
		    overnightOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
			#TblTransaodl.delete_all(OrderNumber: order_number)
            TblTransaodl.destroy_all(OrderNumber: order_number)
	       # puts "done"
            mvr.destroy
		   end
   
            
      #deleting overnight  orders from orderAODL	
		overnightOL_mvrs=TblOrderao.where("LicenseNumber=? and State=? and  OnlineUser= ?",dln,statecode,uid)
		  # puts overnightOL_mvrs.length
		    overnightOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
			
            TblTransaodl.destroy_all(OrderNumber: order_number)
	       # puts "done"
            mvr.destroy
		   end

      end
      
      
      ##########CDLIS CLEANUP###################
      def self.cleanup_cdlis_data(statecode,ssn)
    
    # Get user info
	uid=0
    test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	test_user.each do|u|
     uid = u['UserId']
	end
    
    # Make sure the DL isn't already ordered
   Tblorderdl.destroy_all(OnlineUser: uid,State:  statecode ,SSN: ssn  )
  
  #deleting overnight  orders from orderAODL	
		overnightOL_mvrs=TblOrderao.where("SSN=? and State=? and  OnlineUser= ?",ssn, statecode,uid)
		  # puts overnightOL_mvrs.length
		    overnightOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
			#TblTransaodl.delete_all(OrderNumber: order_number)
            TblTransaodl.destroy_all(OrderNumber: order_number)
	       # puts "done"
            mvr.destroy
		   end
    #deleting online archive orders from ArchiveOlDL	
	archiveOL_mvrs=TblArchiveoldl.where("SSN=? and State=? and  OnlineUser= ?",ssn,statecode,uid)
		#puts archiveOL_mvrs.length
		    archiveOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
	        #deleting orders from OLDLReadDates table dependency		
	        TblReaddates.destroy_all(OrderNumber: order_number)
            TblTransoldl.destroy_all(OrderNumber: order_number)
			#puts "done"
            
		   mvr.destroy
		   end
        
      #deleting overnight  orders from orderAODL	
		overnightOL_mvrs=TblOrderao.where("SSN=?  and State=? and  OnlineUser= ?",ssn,statecode,uid)
		  # puts overnightOL_mvrs.length
		    overnightOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
			TblTransaodl.delete_all(OrderNumber: order_number)
            TblTransaodl.destroy_all(OrderNumber: order_number)
	       # puts "done"
            mvr.destroy
		   end
     #deleting overnight archive orders from ArchiveAODL	
		overnightAROL_mvrs=TblArchiveaodl.where("SSN=?  and State=? and  OnlineUser= ?",ssn,statecode,uid)
		  # puts overnightAROL_mvrs.length
		    overnightAROL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
			TblAOReaddates.destroy_all(OrderNumber: order_number)
	       # puts "done"
            mvr.destroy
		
		   end	   
        
    end    

      
       ##########Batch Search###################       
       
     def self.search_uploaded_batch(dls_in_upload_file)
       MainMenu.select_menu_item("Search Batch")
       batchid=Search.click_batch_id_ordered
      return :batchid
       #Search.verify_batch_order_details(batchid,dls_in_upload_file)
     end
     
       def self.click_batch_id_ordered
       page.has_title?("Batch Search") 
       $batch_id=  page.find(:xpath,"//table[@id='AutoNumber10']/tbody/tr[2]/td[2]/a").text
       
       page.find(:xpath,"//table[@id='AutoNumber10']/tbody/tr[2]/td[2]/a").click
       return $batch_id
       end
       
       def self.verify_batch_order_number(batch_id,dls_in_upload_file)         
         page.has_title?("Batch Details")
         tv=page.find(:xpath,"//table[@id='AutoNumber4']//td").text.to_s
         batch_number=tv[-3,3] 
         return :batch_number
         
       end
       def self.verify_batch_order_details (dls_in_upload_file) 
         dls_in_upload_file.each do |record| 
         puts "***************#{record[0]}*********#{record[1]}***#{record[2]}***#{record[3]}*********"
   
      #page.first(:xpath,"//table[@class='searchData']//tr[(td[4]='#{record[0]}') and (td[8]='#{record[1]}') and (td[9]='#{record[2]}') and (td[14]='#{record[3]}')]")
    
       end
       end
end