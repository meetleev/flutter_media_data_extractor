#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint media_data_extractor.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'media_data_extractor'
  s.version          = '0.0.2'
  s.summary          = 'Extracts video file metadata. Retrieve video details efficiently.'
  s.description      = <<-DESC
Extracts video file metadata. Retrieve video details efficiently.
                       DESC
  s.homepage         = 'https://github.com/meetleev'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'skyza' => 'meetleev@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.14'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
