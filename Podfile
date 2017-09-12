source 'git@scm.applidium.net:CocoaPodsSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.1'
use_frameworks!

pod 'CocoaLumberjack/Swift', '~>  3.0', :inhibit_warnings => true
pod 'ADDynamicLogLevel', '~>  2.0', :inhibit_warnings => true

target 'ADUtilsApp' do
  pod 'Alamofire', '~> 4.0'
  pod 'HockeySDK', '~> 3.8', :subspecs => ['CrashOnlyLib']
  pod 'Watchdog', '~> 3.0'
end

target 'ADUtilsTests' do
  pod 'Quick', '~> 1.1.0'
  pod 'Nimble', '~> 7.0'
  pod 'Nimble-Snapshots', '4.3.0'
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
    end
  end
end
