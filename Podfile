platform :ios, '14.0'
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

            if target.name.include?("ADUtils")
                # Enable complete concurrency checks
                config.build_settings['SWIFT_STRICT_CONCURRENCY'] = "complete"
            end

            # Use same iOS target version on all pods
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "14.0"
        end
    end

    installer.pods_project.build_configurations.each do |config|
        # Enable testability of Pods to have access to ADUtils internal methods during tests
        if config.name == "Stubs"
            config.build_settings['ENABLE_TESTABILITY'] = 'YES'
        end
    end
end
