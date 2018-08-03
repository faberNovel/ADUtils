Pod::Spec.new do |spec|
  spec.name         = 'ADUtils'
  spec.version      = '3.2.0'
  spec.authors      = 'Applidium'
  spec.license      = 'none'
  spec.homepage     = 'http://applidium.com'
  spec.summary      = 'Applidium\'s utily classes for templater'
  spec.ios.deployment_target = '8.1'
  spec.tvos.deployment_target = '9.0'
  spec.license      = { :type => 'Commercial', :text => 'Created and licensed by Applidium. Copyright 2014 Applidium. All rights reserved.' }
  spec.source       = { :git => 'https://github.com/applidium/ADUtils.git', :tag => "v#{spec.version}" }
  spec.framework    = 'Foundation', 'UIKit'
  spec.requires_arc = true

  spec.subspec 'Swift' do |subspec|
    subspec.source_files = 'Modules/ADUtils/*.{h,m,swift}'
  end

  spec.subspec 'objc' do |subspec|
    subspec.dependency 'ADUtils/Swift'
	subspec.source_files = 'Modules/ADUtils_objc/*.{h,m,swift}'
  end

end
