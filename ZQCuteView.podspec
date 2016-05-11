#
#  Be sure to run `pod spec lint ZQCuteView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name          = "ZQCuteView"
  s.version       = "1.0"
  s.platform      = :ios, “7.0”
  s.license       = "MIT"
  s.requires_arc  = true
  s.author        = { "zeqinjie” => “1875193628@qq.com" }
  s.summary       = "带placeholder的TextView"
  s.description   = “粘糖动画view，能响应事件，设置背景图。”
  s.requires_arc  = true
  s.homepage      = "https://github.com/zeqinjie/ZQCuteView”
  s.source        = { :git => "https://github.com/zeqinjie/ZQCuteView.git", :tag => "#{s.version.to_s}" }
  s.source_files  = "ZQCuteView/*.{h,m}"

end
