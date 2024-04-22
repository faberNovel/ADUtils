Pod::Spec.new do |spec|
  spec.name         = 'ADUtils'
  spec.version      = '12.1.1'
  spec.authors      = 'Fabernovel'
  spec.homepage     = 'https://github.com/faberNovel/ADUtils'
  spec.summary      = 'Fabernovel\'s toolbox for iOS'
  spec.ios.deployment_target = '14.0'
  spec.tvos.deployment_target = '14.0'
  spec.license      = { :type => 'MIT', :text => 'Created and licensed by Fabernovel Technologies. Copyright 2014-2018 Fabernovel Technologies. All rights reserved.' }
  spec.source       = { :git => 'https://github.com/faberNovel/ADUtils.git', :tag => "v#{spec.version}" }
  spec.framework    = 'Foundation', 'UIKit'
  spec.requires_arc = true
  spec.default_subspec = 'objc'
  spec.swift_versions = ['5.7']

  spec.subspec 'Swift' do |subspec|
    # Subspec compliant with App extensions
    subspec.dependency 'ADUtils/Privacy'
    subspec.source_files = 'Modules/ADUtils/*.{h,m,swift}'
  end

  spec.subspec 'Security' do |subspec|
    subspec.dependency 'ADUtils/Privacy'
    subspec.source_files = 'Modules/ADUtils_security/*.{h,m,swift}'
    subspec.framework    = 'CryptoKit'
  end

  spec.subspec 'objc' do |subspec|
    subspec.dependency 'ADUtils/Swift'
    subspec.source_files = 'Modules/ADUtils_objc/*.{h,m,swift}'
  end

  spec.subspec 'Privacy' do |subspec|
    subspec.resource_bundles = {'ADUtilsPrivacy' => ['Modules/PrivacyInfo.xcprivacy']}
  end

end
