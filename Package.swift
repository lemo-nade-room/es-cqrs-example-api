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
    ],
    targets: [
        .target(
            name: "EXWebAPI",
            swiftSettings: swiftSettings,
        ),
        .testTarget(
            name: "EXWebAPITests",
            dependencies: [
                .target(name: "EXWebAPI")
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
