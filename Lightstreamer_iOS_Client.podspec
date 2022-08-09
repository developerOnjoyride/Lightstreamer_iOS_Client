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
      spec.platform     = :ios
      spec.ios.deployment_target = '9.0'
      spec.source       = { :http => "https://sdk.lightstreamer.com/ls-ios-client/#{spec.version.to_s}/lib/ls-ios-client-#{spec.version.to_s}.zip" }
      # spec.vendored_frameworks = [
      #   'Lightstreamer_iOS_Client.xcframework'
      # ]
      # spec.frameworks = "Security", "SystemConfiguration"
      # spec.libraries = "iconv"
      spec.requires_arc = true
      spec.default_subspec = "LSVendored"

      spec.subspec 'LSVendored' do |speclsvf|
        speclsvf.vendored_frameworks = [
          'Lightstreamer_iOS_Client.xcframework'
        ]  
        speclsvf.frameworks = "Security", "SystemConfiguration"
        speclsvf.libraries = "iconv"
        end
    end
