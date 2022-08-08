Pod::Spec.new do |spec|

  spec.name         = "Lightstreamer_iOS_Client"
  spec.version      = "4.3.2"
  spec.summary      = "Lightstreamer Client for iOS."
  spec.description  = <<-DESC
  "The Lightstreamer client for iOS lets you:
  
  * Connect to a Lightstreamer Server version 7.0 or greater.
  * Subscribe to items and receive real-time updates, keeping the bandwidth under control.
  * Subscribe to items and receive updates via mobile push notifications (MPN).
  * Send real-time messages to any metadata adapter.
  * Rely on automatic reconnection and subscription in case of network glitches."
                   DESC

  spec.homepage     = "http://www.lightstreamer.com"
  spec.documentation_url  = "https://lightstreamer.com/api/ls-ios-client/4.3.2/"
  spec.license      = {
    :type => "Lightstreamer Software License Agreement",
    :file => "Lightstreamer Software License Agreement.txt"
  }
  spec.author             = { "Lightstreamer": "support@lightstreamer.com" }
  spec.social_media_url   = "https://twitter.com/lightstreamer"
  spec.platform     = :ios, "9.0"
  spec.source       = { :http => "https://www.lightstreamer.com/repo/cocoapods/ls-ios-client/4.3.2/ls-ios-client-4.3.2.zip",
                        :type => "zip" }
  spec.preserve_paths =  'ls-ios-client-' + spec.version.to_s + '/'
  spec.vendored_frameworks = 'ls-ios-client-' + spec.version.to_s + '/Lightstreamer_iOS_Client.xcframework'
  spec.source_files  = 'ls-ios-client-' + spec.version.to_s + '/Lightstreamer_iOS_Client.xcframework/**/*.h'
  spec.frameworks = "Security", "SystemConfiguration"
  spec.libraries = "iconv"
  spec.requires_arc = true
end
