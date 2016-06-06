Pod::Spec.new do |s|
  s.name        = "taresip"
  s.version     = "0.1.0"
  s.author      = { "Michel Atucha" => "miche.atucha@gmail.com" }
  s.homepage    = "https://github.com/miche-atucha/taresip"
  s.summary     = "Cocoapod for baresip."
  s.source      = { :git => "https://github.com/miche-atucha/taresip.git", :tag => "#{s.version}" }
  s.platform    = :ios, '7.0'
  s.license     = { :type => "BSD", :file => "LICENSE" }
  s.description = "Baresip is a portable and modular SIP User-Agent with audio and video support."

  s.source_files        = 'build/baresip/include/**',
                          'build/re/include/**',
                          'build/rem/include/**'
  s.public_header_files = 'build/baresip/include/**',
                          'build/re/include/**',
                          'build/rem/include/**'
  
  s.preserve_paths      = 'build/baresip/include/**/*',
                          'build/re/include/**/*',
                          'build/rem/include/**/*'

  s.vendored_libraries  = 'build/lib/*.a'

  header_search_paths   = '"$(PODS_ROOT)/taresip/build/baresip/include"',
                          '"$(PODS_ROOT)/taresip/build/re/include"',
                          '"$(PODS_ROOT)/taresip/build/rem/include"'

  s.xcconfig            = {'HEADER_SEARCH_PATHS'          => header_search_paths.join(' '),
                           'GCC_PREPROCESSOR_DEFINITIONS' => 'PJ_AUTOCONF=1'}

  s.frameworks          = 'CFNetwork', 'AudioToolbox', 'AVFoundation', 'CoreMedia', 'SystemConfiguration'
  s.libraries           = 'stdc++', 'resolv.9'
  s.requires_arc        = false
end
