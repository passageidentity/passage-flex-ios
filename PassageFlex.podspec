Pod::Spec.new do |s|
  s.name             = 'PassageFlex'
  s.version          = '0.2.0'
  s.summary          = 'Passkey Flex for iOS - Add native passkey authentication to your own Swift authentication flows with Passage by 1Password'
  s.description      = <<-DESC
Passkey Flex for iOS - Add native passkey authentication to your own Swift authentication flows with Passage by 1Password
                       DESC
  s.homepage         = 'http://docs.passage.id/flex'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Passage by 1Password' => 'support@passage.id' }
  s.source           = { :git => 'https://github.com/passageidentity/passage-flex-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/PassageFlex/**/*'
  s.exclude_files = ['Sources/PassageFlex/PassageFlex.docc/**/*', 'docs']
  s.dependency 'AnyCodable-FlightSchool'

end