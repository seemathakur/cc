Given (/^I am on search page$/) do

visit 'https://10.121.144.34:8443/search/search_orders.jsp'
page.has_content?('Search')
end

Then (/^I search by order type "(.*?)"$/) do|ordertype|
Search.select_order_type(ordertype)
end

Given (/^order "(.*?)","(.*?)" ,"(.*?)","(.*?)" is ready for search$/) do|ordernumber,license,fileloc,tablename|
#insert into OrderOLDL ( [OrderNumber],[OnlineUser],[DateOfEntry],[OrderType],[LicenseNumber],[Misc],[FilePath]) values ('IZH6P','B55446P','2015-8-10','DL','D3964249','Backsearch','8-13-2015/wB55446P08132015IHROZ' )   
 
Tblorderdl.create("OrderNumber = ? , OnlineUser = ? ,DateOfEntry =?,OrderType=?, LicenseNumber = ? ,Misc=?, FilePath = ?", 'ABC1D', 'B55446P','2015-8-17','DL' ,'D3964249','Search_Unread','82015ROZ')


end

Given (/^drivers with data "(.*?)","(.*?)", "(.*?)", "(.*?)", "(.*?)","(.*?)", "(.*?)", "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)" and "(.*?)" is ready for search$/)do|state,stateCode,orderType,productType,purpose,dln,lastName,firstName,midName, dob, gender,ssn, misc,orderstatus|
    @state= state
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
    @orderstatus=orderstatus
   
    Search.cleanup_dl_data(@stateCode,@dln,@misc)
    Search.setup_dl_order(@state,@stateCode,@orderType,@productType,@purpose, @dln,@lastName, @firstName,@midName , @dob, @gender,@ssn, @misc,@orderstatus)
    
     
end

Then (/^I search "(.*?)" orders by order type "(.*?)"$/)do|orderstatus,ordertype|
Search.select_order_status(orderstatus)
Search.select_order_type(ordertype)
Search.submit_search_button

end

Then (/^I verify search results by order type "(.*?)"$/)do |ordertype|
Search.verify_search_data
end

Then (/^I verify VR search results by order type "(.*?)"$/)do |ordertype|
Search.verify_vr_search_data
end

Given(/^VR with data "(.*?)","(.*?)", "(.*?)", "(.*?)", "(.*?)","(.*?)","(.*?)","(.*?)" and "(.*?)" is ready for search$/) do |state,stateCode,orderType,productType,purpose,vin,plate,misc,orderstatus|
 @state= state
    @stateCode = stateCode
	@orderType = orderType
	@productType = productType
	@purpose = purpose
	@vin=vin
    @plate=plate
    @misc = misc
    @orderstatus=orderstatus
   
    Search.cleanup_vr_data(@stateCode,@misc)
    Search.setup_vr_order(@state,@stateCode,@orderType,@productType,@purpose,@vin,@plate, @misc,@orderstatus)
end


Given (/^the file contains drivers:$/) do |table|
    @dls_in_upload_file = table.hashes # creates array of hashes
          
end


Then (/^I search uploaded batch$/) do
  @batchid=Search.search_uploaded_batch( @dls_in_upload_file)
  @batchnum=Search.verify_batch_order_number(@batchid,@dls_in_upload_file)
  #expect(true).to be_truthy
  #expect(@batchid).to eq(@batchnum)
  Search.verify_batch_order_details (@dls_in_upload_file)    
end

