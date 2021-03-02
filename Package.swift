// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSON",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "JSON",
            targets: ["JSON"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "JSON",
            dependencies: []),
        .testTarget(
            name: "JSONTests",
            dependencies: ["JSON"]),
    ]
)
