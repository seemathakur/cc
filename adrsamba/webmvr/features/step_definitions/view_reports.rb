

Given (/^user "(.*?)" is ordering a DL using driver data:$/) do |userid, table|

    # Capture the data for the DL being ordered
    @driver_add_data = table.rows_hash
	 
    # Get user info
	uid=0
    test_user = TblUserinfo.where("UserId = ?", userid)
	test_user.each do|u|
     uid = u['UserId']
	end
    
    # Make sure the DL isn't already ordered
   Tblorderdl.destroy_all(OnlineUser: uid,State: @driver_add_data['statecode'] ,LicenseNumber:@driver_add_data['dln'] )
    #deleting online archive orders from ArchiveOlDL	
	archiveOL_mvrs=TblArchiveoldl.where("LicenseNumber=? and State=? and  OnlineUser= ?",@driver_add_data['dln'],@driver_add_data['statecode'],uid)
		#puts archiveOL_mvrs.length
		    archiveOL_mvrs.each do|mvr|
	        order_number=mvr['OrderNumber']
			#puts order_number
	        #deleting orders from OLDLReadDates table dependency		
	        TblReaddates.destroy_all(OrderNumber: order_number)
			#puts "done"
            
		   mvr.destroy
		   end

	end   
	
	When (/^I place the DL order$/) do
    # relies on @driver_add_data being set
    ReportManager.submit_add_driver(@driver_add_data)
   end


Then(/^I should see the DL order on "(.*?)" page$/) do|pagename|
    
	   #MainMenu.select_menu_item("Pending Reports")
	  # sleep 5
	  
	  if pagename=="Pending Reports"
	  MainMenu.select_menu_item("#{pagename}")
	  ReportManager.select_ordertype_to_view(@driver_add_data)
	  orderstatus=ReportManager.check_order_exists("#{pagename}")
	  puts "ORDER STATUS pending report page"
	  puts orderstatus
	    if orderstatus=="reportExists"
	    report_on_Pending_page=ReportManager.verify_pending_order(@driver_add_data,pagetitle) 
		puts report_on_Pending_page
		else
		puts "Order incomplete due to System error"
		end
	  
	   
	   
	elsif pagename=="Unread Reports"
	
	     MainMenu.select_menu_item("Pending Reports")
         MainMenu.select_menu_item("#{pagename}")
	     ReportManager.select_ordertype_to_view(@driver_add_data)
	     ReportManager.refresh_new_unread_order
		 
		 #MainMenu.select_menu_item("Pending Reports")
		 #MainMenu.select_menu_item("#{pagename}")
	     #ReportManager.select_ordertype_to_view(@driver_add_data)
		 #ReportManager.refresh_new_unread_order
		 # three cases for report to appear:case 1-no match found case 2-report exists case 3 report is still on pedning page
		 orderstatus=ReportManager.check_order_exists("#{pagename}")
	    
		 if orderstatus=="noReportExists"
		 report_on_Pending_page=ReportManager.verify_pending_order(@driver_add_data,"Pending Reports") 
		 puts "checking from unread reports scenario"
		 puts report_on_Pending_page
		 else		 
         ReportManager.dlorder_added?(pagename,@driver_add_data)
		 end
	 else
	 
	     MainMenu.select_menu_item("Pending Reports")
         MainMenu.select_menu_item("Unread Reports")
	     ReportManager.select_ordertype_to_view(@driver_add_data)
	     #ReportManager.refresh_new_unread_order
		 
		 ## MainMenu.select_menu_item("Pending Reports")
         ##MainMenu.select_menu_item("Unread Reports")
	    ## ReportManager.select_ordertype_to_view(@driver_add_data)
	     #ReportManager.refresh_new_unread_order
		 # three cases for report to appear:case 1-no match found case 2-report exists case 3 report is still on pedning page
		 #orderstatus=ReportManager.check_order_exists("Unread Reports")
	     
		 #if orderstatus=="noReportExists"
		#report_on_Pending_page=ReportManager.verify_pending_order(@driver_add_data,"Pending Reports") 
		 
		 #puts report_on_Pending_page
		 #else		 
         ReportManager.dlorder_added?("Unread Reports",@driver_add_data)
		 #end
	     ReportManager.open_dlorder_added_in_popup?(@driver_add_data)
	     MainMenu.select_menu_item("#{pagename}")
	     ReportManager.select_ordertype_to_view(@driver_add_data)
	     ReportManager.dlorder_added?("Archived Reports",@driver_add_data)
	    
	  
	end
end

 Then (/^I should verify the full dl report in popup under "(.*?)" page$/)do|pagename|
    ReportManager.open_dlorder_added_in_popup?(@driver_add_data)
    ReportManager.verify_DL_report_in_popup(pagename,@driver_add_data)
	
  end
  
  
   #----------------------#
  #####VR order ##########
  #----------------------#
 
  Given (/^user "(.*?)" is ordering VR by vin:$/) do |userid, table|

    # Capture the data for the VR being ordered
    @vr_add_data = table.rows_hash
	 
    # Get user info
	uid=0
    test_user = TblUserinfo.where("UserId = ?", userid)
	test_user.each do|u|
     uid = u['UserId']
	end
    
    # Make sure the VR isn't already ordered
   Tblordervr.destroy_all(OnlineUser: uid,State: @vr_add_data['statecode'] ,Misc:@vr_add_data['misc'] )
    #deleting orders from archiveVR
   orderAR_vrs=TblArchivevr.where("State=? and  OnlineUser= ? and Misc=?",@vr_add_data['statecode'],uid,@vr_add_data['misc'])
      #puts orderAR_vrs.length
	 orderAR_vrs.each do|vr|
	 order_number=vr['OrderNumber']
	 #puts order_number
	   #deleting orders from readdate table dependency		
	  TblVReaddates.destroy_all(OrderNumber: order_number)
	  #  puts "done"
      vr.destroy
	   end
	end   
  
  
  Given (/^user "(.*?)" is ordering VR by plate:$/) do |userid, table|

    # Capture the data for the VR being ordered
    @vr_add_data = table.rows_hash
	 
    # Get user info
	uid=0
    test_user = TblUserinfo.where("UserId = ?", userid)
	test_user.each do|u|
     uid = u['UserId']
	end
    
    # Make sure the VR isn't already ordered
    Tblordervr.destroy_all(OnlineUser: uid,State: @vr_add_data['statecode'] ,Misc:@vr_add_data['misc'] )
    #deleting orders from archiveVR
   orderAR_vrs=TblArchivevr.where("State=? and  OnlineUser= ? and Misc=?",@vr_add_data['statecode'],uid,@vr_add_data['misc'])
     # puts orderAR_vrs.length
	 orderAR_vrs.each do|vr|
	 order_number=vr['OrderNumber']
	 #puts order_number
	   #deleting orders from readdate table dependency		
	  TblVReaddates.destroy_all(OrderNumber: order_number)
	   # puts "done"
      vr.destroy
	   end
	end   
  
  
  When (/^I place the VR order$/) do
    # relies on @vr_add_data being set
    ReportManager.submit_order_vr(@vr_add_data)
   end
   
   
   Then(/^I should see the VR order on "(.*?)" page$/) do|pagename|
    
	   MainMenu.select_menu_item("Pending Reports")
	   
	   if(pagename=='Unread Reports')
       MainMenu.select_menu_item("#{pagename}")
	   ReportManager.select_ordertype_to_view(@vr_add_data)
	   ReportManager.refresh_new_unread_order
       ReportManager.vrorder_added?(pagename,@vr_add_data)
	else
	   MainMenu.select_menu_item("Unread Reports")
	   ReportManager.select_ordertype_to_view(@vr_add_data)
	   ReportManager.refresh_new_unread_order
       ReportManager.vrorder_added?("Unread Reports",@vr_add_data)
	   ReportManager.open_vrorder_added_in_popup?(@vr_add_data)
	   MainMenu.select_menu_item("#{pagename}")
	   ReportManager.select_ordertype_to_view(@vr_add_data)
	   ReportManager.vrorder_added?("Archived Reports",@vr_add_data)
	end
	end
	
	Then (/^I should verify the full vr report in popup under "(.*?)" page$/)do|pagename|
    ReportManager.open_vrorder_added_in_popup?(@vr_add_data)
    ReportManager.verify_VR_report_in_popup(pagename,@vr_add_data)
	
  end
  
  #----------------------#
  #####DELETE ORDER ##########
  #----------------------#
  
  Given (/^user "(.*?)" is deleting a DL using driver data:$/) do |userid, table|

    # Capture the data for the driver being added
    @driver_delete_data = table.rows_hash

    # Get user info
	#uid=0
	order_number=""
    #test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	#test_user.each do|u|
     #uid = u['UserId']
	#end
    
   

    # Make sure the driver we are deleting from the list isn't currently in a deleted state
	
	 orderAR_mvrs=TblArchiveoldl.where("LicenseNumber=? and State=? and  OnlineUser= ?",@driver_delete_data['dln'],@driver_delete_data['statecode'],'B55446P')
       orderAR_mvrs.each do|mvr|
       
	     order_number=mvr['OrderNumber']
	    end
	    
	@driverToDeleteId = order_number
    #orderAR_mvrs.update(MarkedDelFlag: 0)
     #click on Archive reports link   
    MainMenu.select_menu_item("Archive Reports")
   

end


When /^I delete the driver from the Archive Reports page$/ do
    ReportManager.delete_driver_from_page(@driverToDeleteId)
end

Then /^the driver should be removed from the Archive Reports page$/ do
    #assert_equal(true, ListManager.num_drivers_deleted?(1))
    ReportManager.check_record_deleted
end
  
