Pod::Spec.new do |s|
  s.name     = 'wrapper'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'An Objective-C Github Wrapper'
  s.author   = { 'adsantos' => 'adrianasucena@gmail.com' }
  s.homepage = 'https://github.com/adsantos/GithubWrapper'
  s.source   = { :git => 'ssh://github.com:adsantos/GithubWrapper.git' }
  s.description = 'An Objective-C Github Wrapper.'
  s.platform = :ios
  s.source_files = 'Wrapper/Framework/**/*.{h,m}'
  s.clean_paths   = 'Wrapper.xcodeproj'
  s.dependency 'AFNetworking', '~> 0.10.0'
  s.framework = 'SystemConfiguration'
  s.requires_arc = true

end
