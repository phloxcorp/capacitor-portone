// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorPortone",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorPortone",
            targets: ["CapacitorPortOnePlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0"),
        .package(url: "https://github.com/portone-io/ios-sdk.git", from: "0.0.10")
    ],
    targets: [
        .target(
            name: "CapacitorPortOnePlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm"),
                .product(name: "PortOneSdk", package: "ios-sdk")
            ],
            path: "ios/Sources/CapacitorPortOnePlugin"),
        .testTarget(
            name: "CapacitorPortOnePluginTests",
            dependencies: ["CapacitorPortOnePlugin"],
            path: "ios/Tests/CapacitorPortOnePluginTests")
    ]
)