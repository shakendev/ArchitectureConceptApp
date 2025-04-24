// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedUI",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "SharedUI",
            targets: ["SharedUI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Melon-Fashion-Group/MelonUI", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SharedUI",
            dependencies: [
                .product(name: "MelonUI", package: "MelonUI")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
