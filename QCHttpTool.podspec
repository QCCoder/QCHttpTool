#
#  Be sure to run `pod spec lint QCHttpTool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "QCHttpTool"
  s.version      = "1.0.0"
  s.summary      = "Lib of QC."
  s.description  = <<-DESC
                    Lib of HttpTool.
                   DESC

  #s.homepage     = ""
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "qiancheng" => "596896692@qq.com" }
  s.source       = { :git => "git@github.com:QCCoder/QCHttpTool.git", :tag => "#{s.version}" }
  s.platform     = :ios, "8.0"

  s.source_files = 'QCHttpTool/QCHttpTool/**/*'
  s.public_header_files = 'QCHttpTool/QCHttpTool/**/*.h'
  s.dependency 'AFNetworking' , 'YYModel'

end
