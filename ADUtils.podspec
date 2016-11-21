Pod::Spec.new do |spec|
  spec.name         = 'ADUtils'
  spec.version      = '0.0.1'
  spec.authors      = 'Applidium'
  spec.license      = 'none'
  spec.homepage     = 'http://applidium.com'
  spec.summary      = 'Applidium\'s utily classes for templater'
  spec.platform     = 'ios', '8.1'
  spec.license      = { :type => 'Commercial', :text => 'Created and licensed by Applidium. Copyright 2014 Applidium. All rights reserved.' }
  spec.source       = { :git => 'https://github.com/applidium/ADUtils.git', :tag => "v#{spec.version}" }
  spec.source_files = 'Modules/ADUtils/*.{h,m,swift}'
  spec.framework    = 'Foundation', 'UIKit'
  spec.requires_arc = true
end
