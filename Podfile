platform :ios, '13.0'
use_frameworks!

target 'ADUtilsApp' do
    pod 'SwiftLint', '~> 0.36'
end

target 'ADUtilsTests' do
    pod 'Quick', '~> 7.0'
    pod 'Nimble', '~> 12.0'
    pod 'OCMock', '~> 3.9'
    pod 'ADUtils', :path => './'
    pod 'ADUtils/Security', :path => './'
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
