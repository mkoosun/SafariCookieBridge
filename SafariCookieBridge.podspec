
Pod::Spec.new do |s|
  s.name             = 'SafariCookieBridge'
  s.version          = '1.0.2'
  s.summary          = 'Get and Set data via Safari Cookie'

  s.description      = <<-DESC
SafariCookieBridge can get data from Safari's Cookie, and also set data to Cookie. Very convenient to transfer data between App and Web, even if App is not installed. You can fetch cookie data after user install your App, and let user continue to do something that he want do in Web Page.
                       DESC

  s.homepage         = 'https://github.com/mkoosun/SafariCookieBridge'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wanglin.sun' => 'mkoosun@gmail.com' }
  s.source           = { :git => 'https://github.com/mkoosun/SafariCookieBridge.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.frameworks = 'UIKit'
  s.source_files = 'SafariCookieBridge/Classes/**/*'
end
