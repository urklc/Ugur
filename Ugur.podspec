#
# Be sure to run `pod lib lint Ugur.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ugur'
  s.version          = '1.2.0'
  s.summary          = 'Handful tools every project needs.'

  s.homepage         = 'https://github.com/urklc/Ugur'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'urklc' => 'ugurkilic@live.com' }
  s.source           = { :git => 'https://github.com/urklc/Ugur.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = ['4.2']

  s.source_files = 'Classes/**/*'

end
