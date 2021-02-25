// swift-tools-version:5.3
//
// Copyright (c) Lightstreamer Srl
// See LICENSE.md for license terms
//

import PackageDescription

let package = Package(
    name: "Lightstreamer_iOS_Client",
    platforms: [
        .iOS("9.0")
    ],
    products: [
        .library(
            name: "Lightstreamer_iOS_Client", 
            targets: ["Lightstreamer_iOS_Client_Wrapper"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Lightstreamer_iOS_Client_Wrapper",
            dependencies: [
                .target(name: "Lightstreamer_iOS_Client")
            ],
            path: "Sources",
            linkerSettings: [
                .linkedLibrary("iconv"),
                .linkedFramework("Security"),
                .linkedFramework("SystemConfiguration")
            ]
        ),
        .binaryTarget(
            name: "Lightstreamer_iOS_Client", 
            url: "https://www.lightstreamer.com/repo/cocoapods/ls-ios-client/4.3.1/ls-ios-client-4.3.1.zip", 
            checksum: "2e85f903cf999de7e419ef581a7ea47c3084b296035fb4aa995f16524cfe7793"
        )
    ]
)
