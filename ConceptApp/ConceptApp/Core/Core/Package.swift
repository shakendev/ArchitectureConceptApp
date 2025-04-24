// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v18),
        .macCatalyst(.v18)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Melon-Fashion-Group/MelonKit", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "MelonKit", package: "MelonKit")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
