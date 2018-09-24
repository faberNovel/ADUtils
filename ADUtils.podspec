Pod::Spec.new do |spec|
  spec.name         = 'ADUtils'
  spec.version      = '7.2.1'
  spec.authors      = 'Applidium'
  spec.homepage     = 'http://applidium.com'
  spec.summary      = 'Applidium\'s toolbox for iOS'
  spec.ios.deployment_target = '8.1'
  spec.tvos.deployment_target = '9.0'
  spec.license      = { :type => 'MIT', :text => 'Created and licensed by Fabernovel Technologies. Copyright 2014-2018 Fabernovel Technologies. All rights reserved.' }
  spec.source       = { :git => 'https://github.com/applidium/ADUtils.git', :tag => "v#{spec.version}" }
  spec.framework    = 'Foundation', 'UIKit'
  spec.requires_arc = true
  spec.default_subspec = 'objc'

  spec.subspec 'Swift' do |subspec|
    # ADUtils_noext contains classes which depend on APIs not compliant with App extensions (such as UIApplication.shared)
    subspec.source_files = 'Modules/ADUtils/*.{h,m,swift}', 'Modules/ADUtils_noext/*.{h,m,swift}'
  end

  spec.subspec 'Swift-ext' do |subspec|
    # Subspec compliant with App extensions
    subspec.source_files = 'Modules/ADUtils/*.{h,m,swift}'
  end

  spec.subspec 'objc' do |subspec|
    subspec.dependency 'ADUtils/Swift'
	subspec.source_files = 'Modules/ADUtils_objc/*.{h,m,swift}'
  end

  spec.subspec 'objc-ext' do |subspec|
    # Subspec compliant with App extensions
    subspec.dependency 'ADUtils/Swift-ext'
	subspec.source_files = 'Modules/ADUtils_objc/*.{h,m,swift}'
  end

end
