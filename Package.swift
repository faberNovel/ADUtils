// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ADUtils",
    platforms: [
        .iOS(.v10),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "ADUtils",
            targets: ["ADUtils"]
        ),
        .library(
            name: "ADUtilsSecurity",
            targets: ["ADUtilsSecurity"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ADUtils",
            dependencies: [],
            path: "Modules",
            exclude: ["ADUtils_security"]
        ),
        .target(
            name: "ADUtilsSecurity",
            dependencies: [],
            path: "Modules/ADUtils_security"
        )
    ]
)
