Pod::Spec.new do |s|
s.name             = "ZYKit"

s.version          = "1.1.7"
s.summary          = "A marquee view used on iOS."
s.description      = <<-DESC
It is a marquee view used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/ZYLottery/ZYKit"
# s.screenshots      = ""
s.license          = 'MIT'
s.author           = { "章鱼彩票" => "appdeveloper@8win.com" }
s.source           = { :git => "https://github.com/ZYLottery/ZYKit.git", :tag => s.version.to_s }
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
s.dependency 'Masonry'
s.dependency 'SDWebImage'
s.dependency 'MJRefresh'
s.dependency 'MBProgressHUD'
s.dependency 'SensorsAnalyticsSDK'
s.dependency 'MJExtension'
s.dependency 'SimulateIDFA'

end
