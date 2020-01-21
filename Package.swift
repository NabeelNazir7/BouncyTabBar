// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BouncyTabBar",
    products: [
        .library(
            name: "BouncyTabBar",
            targets: ["BouncyTabBar"]),
    ],
    targets: [
        .target(
            name: "BouncyTabBar",
            path: "Source/"),
    ]
)
