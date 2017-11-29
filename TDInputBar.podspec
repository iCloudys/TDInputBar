
Pod::Spec.new do |s|

s.name         = "TDInputBar"
s.version      = "1.2.0"
s.summary      = "An InputBar same as QQ or WeChat adopt iPhoneX"
s.description  = <<-DESC
An InputBar same as QQ or WeChat
    类似于QQ或者微信的输入框，适配iPhoneX
                DESC
s.homepage     = "https://github.com/iCloudys/TDInputBar"
s.license      = "MIT"
s.author             = { "kong" => "m18301125620@163.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/iCloudys/TDInputBar.git", :tag => "#{s.version}" }
s.source_files  = "TDInputBar/*.{h,m}"
s.resource  = "TDInputBar/TDInputBar.bundle"
s.requires_arc = true

end
