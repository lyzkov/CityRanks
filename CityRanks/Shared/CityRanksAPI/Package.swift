// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "CityRanksAPIClient",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_11),
        .tvOS(.v9),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "CityRanksAPIClient",
            targets: ["CityRanksAPIClient"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CityRanksAPIClient",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
