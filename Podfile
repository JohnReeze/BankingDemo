platform :ios, '11.0'

inhibit_all_warnings!

def utils
    pod 'SwiftGen', '~> 6.1.0'
    pod 'SwiftLint', '~> 0.30.1'
end

def common_pods
    utils
	
    pod 'PluggableApplicationDelegate', :git => "https://github.com/surfstudio/PluggableApplicationDelegate.git", :commit=>"b24aabe3f34d51072cee5cac3b576dbb1f4ca9ec"
    pod 'Nuke', '~> 8.4.1'

end

target 'BankingDemoDebug' do
	use_frameworks!
	common_pods
end


target 'BankingDemoRelease' do
	use_frameworks!
	common_pods
end
