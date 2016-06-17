
module MainMenu
	extend Capybara::DSL
    
    def self.select_menu_item(*menuitems)
        menuitems.each {|menuitem| click_link(menuitem) }
    end
end
