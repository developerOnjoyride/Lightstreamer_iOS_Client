# Lightstreamer SDK for iOS Clients

This SDK includes the resources needed to develop an application for iPhone or iPad that works as a client of Lightstreamer Server.

This client implements the Lightstreamer Unified Client API. The goal of the Unified API is to offer a common set of interfaces and functionalities across different languages and platforms.

This SDK is compatible with iOS 9.0 and newer.

The library is distributed as an XCFramework that supports compilations targeted to the simulator, to a physical device with ARMv7 or ARM64 architectures, and to Mac Catalyst. Bitcode segments are included.

The library is available for import through Swift Package Manager or via direct traditional download.

## Importing the Library via Swift Package Manager

Follow these simple steps:

* Select your Xcode project, then click on "Swift Packages".
* Click on the "+" button and enter the following repository URL: https://github.com/Lightstreamer/Lightstreamer_iOS_Client.git
* In the Package Options panel select the "Exact" version rule specifying the latest version, or whatever other rule you consider appropriate.
* Once completed, add the framework in the appropriate targets of your project.
* Finally, add the following import line wherever you need the client library's services:
    
  ```
  #import <Lightstreamer_iOS_Client/Lightstreamer_iOS_Client.h>
  ```

## Importing the Library Traditionally

If Swift Package Manager is not for you, you can still install the library more traditionally by following these steps:

* Download the iOS client library's distribution from [our website](https://lightstreamer.com/res/ls-ios-client/4.3.2/lib/ls-ios-client-4.3.2.zip).
* Unzip the library's distribution and copy the framework inside your project.
* Once completed, add the framework in the appropriate targets of your project.
* In the target's Build Phases page, also add the following libraries in the Link Binary With Libraries section:
  SystemConfiguration.framework, Security.framework, libiconv
* Finally, add the following import line wherever you need the client library's services:

  ```
  #import <Lightstreamer_iOS_Client/Lightstreamer_iOS_Client.h>
  ```
