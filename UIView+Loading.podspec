Pod::Spec.new do |s|
  s.name             = "UIView+Loading"
  s.version          = "1.0.0"
  s.summary          = "Category to show a loading indicator inside any kind of UIView."
  s.homepage         = "https://github.com/needbee/uiview-loading"
  s.license          = 'MIT'
  s.author           = { "Josh Justice" => "josh@need-bee.com" }
  s.source           = { :git => "https://github.com/needbee/uiview-loading.git", :tag => s.version.to_s }
  s.platform         = :ios, '6.0'
  s.requires_arc     = true
  s.source_files     = 'src', 'src/**/*.{h,m}'
end
