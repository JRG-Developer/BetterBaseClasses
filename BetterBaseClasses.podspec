Pod::Spec.new do |s|
  s.platform     = :ios
  s.ios.deployment_target = "7.0"
  s.name         = "BetterBaseClasses"
  s.version      = "1.6.2"
  s.summary      = "BetterBaseClasses are abstract, base classes meant to be subclassed. They make creating CocoaPods easier."
  s.homepage     = "https://github.com/JRG-Developer/BetterBaseClasses"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Joshua Greene" => "jrg.developer@gmail.com" }
  s.source   	   = { :git => "https://github.com/JRG-Developer/BetterBaseClasses.git", :tag => "#{s.version}"}
  s.framework    = "UIKit"
  s.requires_arc = true

  s.source_files = "BetterBaseClasses/BetterBaseClasses.h"

  s.subspec 'Constants' do |ss|
    ss.source_files = "BetterBaseClasses/BetterBaseConstants.h", "BetterBaseClasses/Constants/*.{h,m}"
  end

  s.subspec 'Controllers' do |ss|
    ss.source_files = "BetterBaseClasses/BetterBaseControllers.h", "BetterBaseClasses/Controllers/*.{h,m}"
    ss.dependency 'BetterBaseClasses/Constants'
  end

  s.subspec 'Views' do |ss|
    ss.source_files = "BetterBaseClasses/BetterBaseViews.h", "BetterBaseClasses/Views/*.{h,m}"
  end

end
