source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
use_frameworks!


target 'ADUtilsApp' do
end

target 'ADUtilsTests' do
    pod 'Quick', '~> 2.0'
    pod 'Nimble', '~> 7.0'
    pod 'Nimble-Snapshots', '~> 6.9'
    pod 'OCMock', '~> 3.4'
    pod 'ADUtils', :path => './'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|

            config.build_settings['SWIFT_VERSION'] = '4.2'

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
