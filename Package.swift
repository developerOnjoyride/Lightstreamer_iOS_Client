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
            url: "https://www.lightstreamer.com/repo/cocoapods/ls-ios-client/4.3.2/ls-ios-client-4.3.2.zip", 
            checksum: "90e04c3ea876bc35a5b5abbb8aa8ee16211c75d55c8d7695e88e2ebbbcb48f15"
        )
    ]
)
