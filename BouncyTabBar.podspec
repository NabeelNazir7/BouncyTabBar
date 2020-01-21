#
# Be sure to run `pod lib lint BouncyTabBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BouncyTabBar'
  s.version          = '1.0.0'
  s.summary          = 'A light way to add customization with animation to your tab bar view'
  s.swift_version = "5.0"

  s.description      = <<-DESC
 It is an iOS UI library for adding animation to iOS tabbar items and icons
                       DESC

  s.homepage         = 'https://github.com/shahbazsaleem01/BouncyTabBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Shahbaz Saleem' => 'shahbaz@saleems.me' }
  s.source           = { :git => 'https://github.com/shahbazsaleem01/BouncyTabBar.git', :tag => "#{s.version}" }
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/**/*'
end
