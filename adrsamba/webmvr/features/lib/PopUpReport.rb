module PopUpReport
	extend Capybara::DSL
   
   def self.openpopup(title)
   handler=page.driver.find_window("#{title}")
   return handler
   end
   
     def self.closepopup(title)
	 handler=page.driver.find_window("#{title}")
	 page.driver.browser.switch_to.window(handler)
	 page.driver.browser.close
	 end
end



