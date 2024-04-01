Pod::Spec.new do |s|
  s.name             = 'PassageFlex'
  s.version          = ENV['LIB_VERSION'] || '0.1.0' #fallback to major version
  s.summary          = 'Use Passage Flex in your iOS application'
  s.homepage         = 'https://github.com/passageidentity/passage-flex-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Passage Identity, Inc' => 'hello@passage.id' }
  s.source           = { :git => 'https://github.com/passageidentity/passage-flex-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/PassageFlex/**/*'
  s.exclude_files = ['Sources/PassageFlex/PassageFlex.docc/**/*', 'docs']
  s.dependency 'AnyCodable-FlightSchool'

end