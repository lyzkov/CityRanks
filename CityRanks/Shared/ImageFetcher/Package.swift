// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ImageFetcher",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "ImageFetcher",
            targets: ["ImageFetcher"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ImageFetcher",
            dependencies: []),
    ]
)
