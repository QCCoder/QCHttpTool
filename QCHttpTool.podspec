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
  s.source       = { :git => "git@192.168.100.138:qiancheng/YLlib-ios.git", :tag => "#{s.version}" }
  s.platform     = :ios, "8.0"

  s.source_files = 'QCHttpTool/QCHttpTool/**/*'
  s.public_header_files = 'QCHttpTool/QCHttpTool/**/*.h'
  s.dependency 'AFNetworking'
  s.dependency 'YYModel'

end
