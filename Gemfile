source 'https://rubygems.org'
ruby '3.3.0'

gem 'cocoapods', '~> 1.16'
gem 'CFPropertyList', '~> 3.0.0'
gem 'fastlane', '<3.0'
gem 'danger'
gem 'danger-swiftlint'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
