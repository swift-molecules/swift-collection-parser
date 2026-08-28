// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-collection-parser",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Collection Parser Match", targets: ["Collection Parser Match"]),
        .library(name: "Collection Parser Consume", targets: ["Collection Parser Consume"]),
        .library(name: "Collection Parser Discard", targets: ["Collection Parser Discard"]),
        .library(name: "Collection Parser Prefix", targets: ["Collection Parser Prefix"]),
        .library(name: "Collection Parser Rest", targets: ["Collection Parser Rest"]),
        .library(name: "Collection Parser End", targets: ["Collection Parser End"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-collection.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-either.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-input.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Collection Parser Match",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Match", package: "swift-parser"),
                .product(name: "Collection Slice", package: "swift-collection"),
                .product(name: "Either", package: "swift-either"),
            ]
        ),
        .target(
            name: "Collection Parser Consume",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Constraint", package: "swift-parser"),
                .product(name: "Collection Slice", package: "swift-collection"),
            ]
        ),
        .target(
            name: "Collection Parser Discard",
            dependencies: [
                .target(name: "Collection Parser Consume"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Constraint", package: "swift-parser"),
                .product(name: "Collection Slice", package: "swift-collection"),
            ]
        ),
        .target(
            name: "Collection Parser Prefix",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Constraint", package: "swift-parser"),
                .product(name: "Parser Match", package: "swift-parser"),
                .product(name: "Collection Slice", package: "swift-collection"),
            ]
        ),
        .target(
            name: "Collection Parser Rest",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Collection Slice", package: "swift-collection"),
            ]
        ),
        .target(
            name: "Collection Parser End",
            dependencies: [
                .target(name: "Collection Parser Match"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Match", package: "swift-parser"),
                .product(name: "Collection Slice", package: "swift-collection"),
            ]
        ),
        .target(
            name: "Collection Parser Test Support",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Input Slice", package: "swift-input"),
                .product(name: "Collection Test Support", package: "swift-collection"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Collection Parser Consume Tests",
            dependencies: [
                .target(name: "Collection Parser Consume"),
                .target(name: "Collection Parser Test Support"),
            ]
        ),
        .testTarget(
            name: "Collection Parser End Tests",
            dependencies: [
                .target(name: "Collection Parser End"),
                .target(name: "Collection Parser Test Support"),
            ]
        ),
        .testTarget(
            name: "Collection Parser Prefix Tests",
            dependencies: [
                .target(name: "Collection Parser Prefix"),
                .target(name: "Collection Parser Test Support"),
            ]
        ),
        .testTarget(
            name: "Collection Parser Rest Tests",
            dependencies: [
                .target(name: "Collection Parser Rest"),
                .target(name: "Collection Parser Test Support"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
