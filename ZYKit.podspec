Pod::Spec.new do |s|
s.name             = "ZYKit"
s.version          = "0.0.2.1"
s.summary          = "A marquee view used on iOS."
s.description      = <<-DESC
It is a marquee view used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/CoderWD/ZYKit"
# s.screenshots      = ""
s.license          = 'MIT'
s.author           = { "何伟东" => "654500619@.com" }
s.source           = { :git => "https://github.com/CoderWD/ZYKit.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/NAME'

s.platform     = :ios, '7.0'
# s.ios.deployment_target = '5.0'
# s.osx.deployment_target = '10.7'
s.requires_arc = true

#s.source_files = 'ZYKit/Class/*'
s.source_files  = 'ZYKit/Class/**/*.{h,m}'


# s.resources = 'Assets'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit', 'AdSupport'
s.dependency 'WDKit'
s.dependency 'Masonry', '~> 1.0.2'
s.dependency 'SDWebImage', '~> 3.8.2'
s.dependency 'MJRefresh', '~> 3.1.12'
s.dependency 'MBProgressHUD', '~> 1.0.0'
s.dependency 'SensorsAnalyticsSDK', '~> 1.6.24'
s.dependency 'MJExtension', '~> 3.0.13'

end
