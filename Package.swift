// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DefaultCodable",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_12)
    ],
    products: [
        .library(
            name: "DefaultCodable",
            targets: ["DefaultCodable"]),
    ],
    targets: [
        .target(
            name: "DefaultCodable",
            path: "Sources"),
        .testTarget(
            name: "DefaultCodableTests",
            dependencies: ["DefaultCodable"]),
    ]
)
