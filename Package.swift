// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeProjSorter",
    products: [
        .executable(name: "xcodeproj-sorter", targets: ["XcodeProjSorter"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "XcodeProj", url: "https://github.com/tuist/xcodeproj.git", .upToNextMajor(from: "8.5.0")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "1.0.2")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "XcodeProjSorter",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "XcodeProj", package: "XcodeProj"),
            ]),
        .testTarget(
            name: "XcodeProjSorterTests",
            dependencies: ["XcodeProjSorter"]),
    ]
)
