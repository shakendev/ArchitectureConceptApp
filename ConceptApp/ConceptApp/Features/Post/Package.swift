// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Post",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "Post",
            targets: ["Post"]
        )
    ],
    dependencies: [
        .package(name: "Core", path: "../Core/Core"),
        .package(url: "https://github.com/Melon-Fashion-Group/MelonKit", from: "1.0.0"),
        .package(url: "https://github.com/Melon-Fashion-Group/MelonUI", from: "1.0.0"),
        .package(name: "SharedUI", path: "../Design System/SharedUI")
    ],
    targets: [
        .target(
            name: "Post",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "MelonKit", package: "MelonKit"),
                .product(name: "MelonUI", package: "MelonUI"),
                .product(name: "SharedUI", package: "SharedUI")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
