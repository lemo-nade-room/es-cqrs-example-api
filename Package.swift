// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-cqrs-example-api",
    platforms: [.macOS(.v15)],
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
    ],
)
var swiftSettings: [SwiftSetting] {
    [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
    ]
}
