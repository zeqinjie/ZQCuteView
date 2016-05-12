#
#  Be sure to run `pod spec lint ZQCuteView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZQCuteView"
  s.version      = "1.0"
  s.summary      = "粘糖动画view，能响应事件，设置背景图。"
  s.description   = "ZQCuteView，能响应事件，设置背景图。"
  s.requires_arc  = true
  s.homepage     = "https://github.com/zeqinjie/ZQCuteView"
  s.license      = "MIT"
  s.author       = { "zhengzeqin" => "1875193628@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/zeqinjie/ZQCuteView.git", :tag => "#{s.version}" }
  s.source_files  = "ZQCuteViewDemo/ZQCuteView.{h,m}"
end
