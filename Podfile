# Uncomment the next line to define a global platform for your project
platform :ios, '14.5'

source 'https://cdn.cocoapods.org/'
source "https://github.com/ApprovedBug/iOS-Specs.git"

target 'APBLocationTracker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for APBLocationTracker
  
  pod 'APBFoundation', '0.1.0'
  pod 'FLKAutoLayout', '1.0.1'

  target 'APBLocationTrackerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'APBLocationTrackerUITests' do
    # Pods for testing
  end

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.5'
        end
    end
end
