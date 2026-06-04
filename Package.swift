// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SemiCircularCarousel",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "SemiCircularCarousel",
            targets: ["SemiCircularCarousel"]
        ),
    ],
    targets: [
        .target(
            name: "SemiCircularCarousel"
        ),
    ]
)
