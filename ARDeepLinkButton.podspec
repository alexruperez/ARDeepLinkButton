Pod::Spec.new do |s|
  s.name         = "ARDeepLinkButton"
  s.version      = "0.1.0"
  s.summary      = "#UIButton subclass that handle deep links, shows in-app #SKStoreProductViewController or redirects to the #AppStore. Written in #Swift 2.0"
  s.homepage     = "https://github.com/alexruperez/ARDeepLinkButton"
  s.screenshots  = "https://raw.githubusercontent.com/alexruperez/ARDeepLinkButton/master/screenshot.png"
  s.license      = "MIT"
  s.author             = { "Alex Rupérez" => "contact@alexruperez.com" }
  s.social_media_url   = "http://twitter.com/alexruperez"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/alexruperez/ARDeepLinkButton.git", :tag => s.version.to_s }
  s.source_files  = "ARDeepLinkButton/**/*.{h,m,swift}"
  s.public_header_files = "ARDeepLinkButton/**/*.h"
  s.frameworks = "UIKit", "StoreKit"
  s.requires_arc = true
end
