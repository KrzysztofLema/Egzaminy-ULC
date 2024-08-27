// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Main",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .singleTargetLibrary("AppRootFeature"),
    ],
    dependencies: [
        .package(url: "https://github.com/krzysztofzablocki/Inject.git", exact: "1.2.3"),
        .package(url: "https://github.com/krzysztofzablocki/Difference.git", exact: "1.0.2"),
        .package(url: "https://github.com/krzysztofzablocki/LifetimeTracker.git", exact: "1.8.2"),
        .package(url: "https://github.com/krzysztofzablocki/AutomaticSettings", exact: "1.1.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.12.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.0"),
        
    ],
    targets: [
        .target(
            name: "AppRootFeature",
            dependencies: [
                "HomeFeature",
                "ExamDetailFeature",
                "ExamsListFeature",
                "QuizFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "AppRootFeatureTest",
            dependencies: [
                "AppRootFeature",
                "TestExtensions",
            ]
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                "SharedViews",
                "SharedModels",
                "ExamsListFeature",
                "SettingsFeature",
                .product(name: "LifetimeTracker", package: "LifetimeTracker"),
                "AutomaticSettings",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "HomeFeatureTest",
            dependencies: [
                "HomeFeature",
                "TestExtensions",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "ExamsListFeature",
            dependencies: [
                "SharedViews",
                "SharedModels",
                "ExamDetailFeature",
                "CoreUI",
                "ExamsClient",
            ]
        ),
        .target(
            name: "SettingsFeature",
            dependencies: [
                "SharedViews",
                "SharedModels",
                "UserSettingsClient",
                "UIApplicationClient",
                "CoreUI",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "UserSettingsClient",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "UIApplicationClient",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "CoreUI",
            dependencies: []
        ),
        .target(
            name: "ExamsClient",
            dependencies: [
                "SharedModels",
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "ExamDetailFeature",
            dependencies: [
                "SharedViews",
                "SharedModels",
                "CoreUI",
                "QuizFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "TestExtensions",
            dependencies: [
                .product(name: "Difference", package: "Difference"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .target(
            name: "SharedViews",
            dependencies: [
                .product(name: "Inject", package: "Inject"),
            ]
        ),
        .target(
            name: "SharedModels",
            dependencies: [
                .product(name: "Difference", package: "Difference"),
                .product(name: "LifetimeTracker", package: "LifetimeTracker"),
                "AutomaticSettings",
            ]
        ),
        .target(
            name: "QuizFeature",
            dependencies: [
                "SharedViews",
                "SharedModels",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "QuizFeatureTest",
            dependencies: [
                "QuizFeature",
                "TestExtensions",
                "SharedModels",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "ExamsListTest",
            dependencies: [
                "ExamsListFeature",
                "TestExtensions",
                "SharedModels",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
    ]
)

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
