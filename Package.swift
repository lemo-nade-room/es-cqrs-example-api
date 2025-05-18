// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-cqrs-example-api",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime.git", from: "1.0.0"),
        .package(
            url: "https://github.com/swift-server/swift-openapi-async-http-client.git",
            from: "1.0.0",
        ),
        .package(
            url: "https://github.com/lemo-nade-room/event-store-adapter-swift.git",
            from: "1.0.0"
        ),
        .package(
            url: "https://github.com/lemo-nade-room/event-store-adapter-swift-support.git",
            branch: "main"
        ),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "EXWebAPI",
            swiftSettings: swiftSettings,
        ),
        .testTarget(
            name: "EXWebAPITests",
            dependencies: [
                .target(name: "EXWebAPI"),
                .target(name: "EXTestUtil"),
            ],
            swiftSettings: swiftSettings,
        ),

        // MARK: Event
        .target(
            name: "EXEvent",
            dependencies: [
                .product(name: "EventStoreAdapter", package: "event-store-adapter-swift"),
                .product(
                    name: "EventStoreAdapterSupport", package: "event-store-adapter-swift-support"),
            ],
            swiftSettings: swiftSettings,
        ),
        .testTarget(
            name: "EXEventTests",
            dependencies: [
                .target(name: "EXEvent"),
                .target(name: "EXTestUtil"),
            ],
            swiftSettings: swiftSettings,
        ),

        // MARK: Application
        .target(
            name: "EXApp",
            dependencies: [
                .target(name: "EXWrite")
            ],
            swiftSettings: swiftSettings,
        ),
        .testTarget(
            name: "EXAppTests",
            dependencies: [
                .product(name: "EventStoreAdapterForMemory", package: "event-store-adapter-swift"),

                .target(name: "EXApp"),
                .target(name: "EXTestUtil"),
            ],
            swiftSettings: swiftSettings,
        ),

        // MARK: Write
        .target(
            name: "EXWrite",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .target(name: "EXEvent"),
            ],
            swiftSettings: swiftSettings,
        ),
        .testTarget(
            name: "EXWriteTests",
            dependencies: [
                .target(name: "EXWrite"),
                .target(name: "EXTestUtil"),
            ],
            swiftSettings: swiftSettings,
        ),

        // MARK: Test Utility
        .target(
            name: "EXTestUtil",
            swiftSettings: swiftSettings,
        ),

        // MARK: External API Test
        .testTarget(
            name: "EXExternalAPITests",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(
                    name: "OpenAPIAsyncHTTPClient",
                    package: "swift-openapi-async-http-client"
                ),

                .target(name: "EXTestUtil"),
            ],
            swiftSettings: swiftSettings,
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ],
        ),
    ],
)
var swiftSettings: [SwiftSetting] {
    [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
    ]
}
