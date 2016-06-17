
doLogoutHook = false

# Before hook is tagged in order to support different login scenarios 
Before('@login') do
    #Login.login("http://staging-sbi:8888/SBI", "rtdemo", "test")
    Login.login(WMVR_URL, TEST_USER, TEST_PASSWORD)
    doLogoutHook = true
end

#Before('@admin-login') do
 #   Login.login(DRM_URL, ADMIN_USER, ADMIN_PASSWORD)
  #  doLogoutHook = true
#end

Before('@nologin') do
    doLogoutHook = false
end
## update when applet is taken out
After do |scenario|
	if doLogoutHook
    	Login.logout
    end
end
