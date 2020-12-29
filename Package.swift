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
            url: "https://www.lightstreamer.com/repo/cocoapods/ls-ios-client/4.3.0/ls-ios-client-4.3.0.zip", 
            checksum: "392af5c6ff749be5dc64a66ec2ae60ab389d8f86a01f67d9554ed083a14bdc48"
        )
    ]
)
