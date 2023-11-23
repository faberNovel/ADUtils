// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ADUtils",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "ADUtils",
            targets: ["ADUtils"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ADUtils",
            dependencies: [],
            path: "Modules"
        )
    ]
)
