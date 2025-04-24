// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Posts",
    platforms: [
        .iOS(.v18),
        .macCatalyst(.v18)
    ],
    products: [
        .library(
            name: "Posts",
            targets: ["Posts"]
        )
    ],
    dependencies: [
        .package(name: "Core", path: "../Core/Core"),
        .package(url: "https://github.com/Melon-Fashion-Group/MelonKit", from: "1.0.0"),
        .package(name: "SharedUI", path: "../Design System/SharedUI")
    ],
    targets: [
        .target(
            name: "Posts",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "MelonKit", package: "MelonKit"),
                .product(name: "SharedUI", package: "SharedUI")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
