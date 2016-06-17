module Datehelper
	extend Capybara::DSL
    
    def self.get_today_date
        dateToday= Date.today 
    end 
end