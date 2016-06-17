
module NoMatchFound
	extend Capybara::DSL
    
    def self.no_match_found
        page.has_content?('No Match Found...')
        return :noreportexists    
    end 
end
