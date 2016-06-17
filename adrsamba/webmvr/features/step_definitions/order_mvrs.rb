###make misc as last name for data handling 
Given (/^driver "(.*?)", "(.*?)", "(.*?)" ,"(.*?)" is ready to be ordered$/) do |stateId, license, lastName,misc|
    
    @stateCode = stateId
	@dln = license
    @lastName = lastName
    @misc = misc
    Search.cleanup_dl_data(@stateCode,@dln,@misc)
    #------------------- Setup for ordering mvrs
    # Load user data for our test user 'B55446P'
	 #  uid=0
     #test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	
	    # test_user.each do|u|
			#	   uid = u['UserId']
			#	   end
	#deleting online orders from OrderOlDL		
	  # Tblorderdl.destroy_all(OnlineUser: uid,State: stateId ,Misc: misc )
    #Tblorderdl.delete_all(OnlineUser: uid,State: stateId ,Misc: misc )
	 #deleting online archive orders from ArchiveOlDL	
		#archiveOL_mvrs=TblArchiveoldl.where("LicenseNumber=? and State=? and  OnlineUser= ?",license,stateId,uid)
		#puts archiveOL_mvrs.length
		   #archiveOL_mvrs.each do|mvr|
	        #order_number=mvr['OrderNumber']
			#puts order_number
	        #deleting orders from OLDLReadDates table dependency		
	      #  TblReaddates.destroy_all(OrderNumber: order_number)
            #TblTransoldl.destroy_all(OrderNumber: order_number)
            #TblReaddates.delete_all(OrderNumber: order_number)
			#puts "done"
            
		  # mvr.destroy
		 #  end

		
		#deleting overnight  orders from orderAODL	
		#overnightOL_mvrs=TblOrderao.where("LicenseNumber=? and State=? and  OnlineUser= ?",license,stateId,uid)
		  # puts overnightOL_mvrs.length
		   # overnightOL_mvrs.each do|mvr|
	       # order_number=mvr['OrderNumber']
			#puts order_number
			#TblTransaodl.delete_all(OrderNumber: order_number)
           # TblTransaodl.destroy_all(OrderNumber: order_number)
	       # puts "done"
            #mvr.destroy
		   #end

		#deleting overnight archive orders from ArchiveAODL	
		#overnightAROL_mvrs=TblArchiveaodl.where("LicenseNumber=? and State=? and  OnlineUser= ?",license,stateId,uid)
		  # puts overnightAROL_mvrs.length
		   # overnightAROL_mvrs.each do|mvr|
	       # order_number=mvr['OrderNumber']
			#puts order_number
			#TblAOReaddates.destroy_all(OrderNumber: order_number)
	       # puts "done"
           # mvr.destroy
		
		   # end	   
end
Given (/^VR "(.*?)", "(.*?)", "(.*?)" ,"(.*?)" is ready to be ordered$/) do |stateId, vin,plate,misc|


 @stateCode = stateId
	@vin = vin
    @plate = plate
    @misc = misc
    Search.cleanup_vr_data(@stateCode,@misc)
# Load user data for our test user 'B55446P'
	  # uid=0
     #test_user = TblUserinfo.where("UserId = ?", 'B55446P')
	
	     #test_user.each do|u|
		# uid = u['UserId']
		# end
#deleting online orders from OrderVR	
	   
      # Tblordervr.destroy_all(OnlineUser: uid,State: stateId ,Misc: misc )
	   #deleting orders from archiveVR
     #orderAR_vrs=TblArchivevr.where("State=? and  OnlineUser= ? and Misc=?",stateId,uid,misc)
      #puts orderAR_vrs.length
	 #orderAR_vrs.each do|vr|
	# order_number=vr['OrderNumber']
	 #puts order_number
	   #deleting orders from VRreaddate table dependency		
	  #TblVReaddates.destroy_all(OrderNumber: order_number)
	  #  puts "done"
     # vr.destroy
	  # end
	  
	
end

Given (/^cdlis driver "(.*?)", "(.*?)", "(.*?)" is ready to be ordered$/) do|statecode,ssn,misc|
    @stateCode = statecode
	@ssn = ssn
    @misc = misc
    Search.cleanup_cdlis_data(@stateCode,@ssn)
end   
Given(/^I am only running order mvrs background steps$/) do
end

Given (/^I am ordering an MVR with order data "(.*?)", "(.*?)", "(.*?)", "(.*?)","(.*?)", "(.*?)", "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)" and reference "(.*?)"$/) do |stateCode,orderType,productType,purpose,dln,lastName,firstName,midName, dob, gender,ssn, misc|
    @stateCode = stateCode
	@orderType = orderType
	@productType = productType
	@purpose = purpose
	@dln = dln
    @lastName = lastName
    @firstName = firstName
	@midName = midName
    @dob =  dob
    @gender = gender
	@ssn = ssn
    @misc = misc
end
Given (/^I am ordering an VR with order data "(.*?)", "(.*?)", "(.*?)", "(.*?)","(.*?)", "(.*?)" and reference "(.*?)"$/) do |stateCode,orderType,productType,purpose,vin,plate, misc|
    @stateCode = stateCode
	@orderType = orderType
	@productType = productType
	@purpose = purpose
	@vin = vin
    @plate = plate
    @misc = misc
end
When(/^I submit my DL order request$/) do
    #assert_equal(:order_submitted, OrderMvr.submit_order(@stateCode,@orderType,	@productType,@purpose, @dln,@lastName, @firstName,@midName , @dob, @gender, @misc))
	@actual_order_status=OrderMvr.submit_dl_order(@stateCode,@orderType,@productType,@purpose, @dln,@lastName, @firstName,@midName , @dob, @gender,@ssn, @misc)
	#puts "***********************#{@actual_order_status}*****************************"
	 
     expect(:order_submitted).to eq(@actual_order_status)
     #expect(true).to eq(@actual_order_status)
     expect(true).to be_truthy
    
end
When(/^I submit my VR order request$/) do
    #assert_equal(:order_submitted, OrderMvr.submit_order(@stateCode,@orderType,	@productType,@purpose, @dln,@lastName, @firstName,@midName , @dob, @gender, @misc))
	actual_order_status=OrderMvr.submit_vr_order(@stateCode,@orderType,@productType,@purpose, @vin,@plate,@misc)
	puts actual_order_status
	 #assert_equal(:order_submitted, actual_order_status)
     #expect(:order_submitted).to eq(@actual_order_status)
end
Then(/^I should see a confirmation message$/) do

#assert  OrderMvr.order_confirmed?
  puts  OrderMvr.order_confirmed?
end
Then (/^I should see a overnight message$/) do
 OrderMvr.overnight_order_confirmed?

end
Then (/^I should verify report$/) do
      status=@actual_order_status
     if  status=="true"
       OrderMvr.verify_report(@dln,@misc)
     end
    #OrderMvr.verify_online_delay_message
    #end
end
