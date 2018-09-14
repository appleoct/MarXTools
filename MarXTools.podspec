#
# Be sure to run `pod lib lint MarXTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MarXTools'
  s.version          = '1.1.3'
  s.summary          = 'MarX Repo'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://gitee.com/erliucxy/MarXTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'codeRiding' => 'coderiding@gmail.com' }
  s.source           = { :git => 'https://gitee.com/erliucxy/MarXTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MarXTools/Classes/MarXTools.h'
  s.public_header_files = 'MarXTools/Classes/MarXTools.h'

# ------------------Subspec-----------------#

  s.subspec 'Handler' do |ss|
    ss.source_files = 'MarXTools/Classes/Handler/**/*'
    ss.public_header_files = 'MarXTools/Classes/Handler/**/*.h'
  end

  s.subspec 'Category' do |ss|
    ss.source_files = 'MarXTools/Classes/Category/**/*'
    ss.public_header_files = 'MarXTools/Classes/Category/**/*.h'
  end
  
  # s.resource_bundles = {
  #   'MarXTools' => ['MarXTools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
