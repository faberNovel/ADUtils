source 'git@scm.applidium.net:CocoaPodsSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.1'
use_frameworks!

pod 'CocoaLumberjack/Swift', '~>  2.0', :inhibit_warnings => true
pod 'ADDynamicLogLevel', '~>  1.1', :inhibit_warnings => true

target 'ADUtils' do
  pod 'Alamofire', '~> 3.5'
  pod 'HockeySDK', '~> 3.8', :subspecs => ['CrashOnlyLib']
  pod 'Watchdog', '~> 1.0'
  pod 'Cleanse', '~> 0.1.0' # Cleanse requires ios 8.1
end

target 'ADUtilsTests' do
  pod 'Quick', '~> 0.9.3'
  pod 'Nimble', '~> 4.0'
  pod 'Nimble-Snapshots', '4.1.0'
  pod 'OCMock', '~> 3.3'
  pod 'FBSnapshotTestCase', '~> 2.1'
  pod 'ADUtils', :path => './'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|

      # Change the Optimization level for each target/configuration
      if !config.name.include?("Distribution")
        config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
      end

      # Disable Pod Codesign
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      config.build_settings['SWIFT_VERSION'] = '2.3'
    end
  end
end
