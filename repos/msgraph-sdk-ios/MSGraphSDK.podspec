
Pod::Spec.new do |s|

  s.name         = "MSGraphSDK"
  s.version      = "0.10.1"
  s.summary      = "Microsoft Graph iOS SDK"
  s.description  = <<-DESC
                    Integrate the Microsoft Graph API into your iOS App!
                   DESC
  s.homepage     = "http://graph.microsoft.io"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author        = 'Microsoft Graph'

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/MicrosoftGraph/msgraph-sdk-ios.git",
                     :tag => "#{s.version}"}

  s.source_files = "MSGraphSDK/MSGraphSDK.h"
  s.public_header_files = "MSGraphSDK/MSGraphSDK.h"

  s.exclude_files = "Examples/*","MSGraphSDK/Test/*"

  s.subspec "Common" do |common|
    common.source_files = "MSGraphSDK/Common/*.{h,m}"
    common.public_header_files = "MSGraphSDK/Common/*.h"
  end

  s.subspec "Implementations" do |impl|
    impl.dependency 'MSGraphSDK/Common'

    impl.source_files = "MSGraphSDK/MSGraphSDK/MSURLSessionManager/*{h,m}", "MSGraphSDK/MSGraphSDK/*{h,m}"
    impl.public_header_files = "MSGraphSDK/MSGraphSDK/MSURLSessionManager/*.h", "MSGraphSDK/MSGraphSDK/*.h"
  end

  s.subspec "MSGraphCoreSDK" do |core|
    core.dependency 'MSGraphSDK/Common'

    core.source_files = "MSGraphSDK/MSGraphCoreSDK/**/*.{h,m}"
    core.public_header_files = "MSGraphSDK/MSGraphCoreSDK/**/*.h"
  end

  s.subspec "Extensions" do |ext|
    ext.dependency 'MSGraphSDK/MSGraphCoreSDK'
    ext.dependency 'MSGraphSDK/Implementations'

    ext.source_files = "MSGraphSDK/Extensions/*.{h,m}"
    ext.public_header_files = "MSGraphSDK/Extensions/*.h"
  end


end
