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
        .singleTargetLibrary("OnboardingFeature"),
        .singleTargetLibrary("CoreUI"),
    ],
    dependencies: [
        .package(url: "https://github.com/krzysztofzablocki/Inject.git", exact: "1.2.3"),
        .package(url: "https://github.com/krzysztofzablocki/Difference.git", exact: "1.0.2"),
        .package(url: "https://github.com/krzysztofzablocki/LifetimeTracker.git", exact: "1.8.2"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.57.0"),
        .package(url: "https://github.com/launchdarkly/ios-client-sdk.git", exact: "9.12.0"),
    ],
    targets: [
        .target(
            name: "AppRootFeature",
            dependencies: [
                "HomeFeature",
                "Services",
                "ExamDetailFeature",
                "ExamsListFeature",
                "MainMenuFeature",
                "OnboardingFeature",
                "UserSettingsClient",
                "QuizFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "LaunchDarkly", package: "ios-client-sdk"),
            ]
        ),
        .testTarget(
            name: "AppRootFeatureTest",
            dependencies: [
                "AppRootFeature",
                "Services",
                "TestExtensions",
            ]
        ),
        .target(
            name: "CoreDataClient",
            dependencies: [
                "SharedModels",
                "ExamsClient",
                "Services",
                "Helpers",
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "CoreUI",
            dependencies: [
                "Providers",
                "SharedViews",
            ]
        ),
        .target(
            name: "CurrentQuizClient",
            dependencies: [
                "SharedModels",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "DiagnosticClient",
            dependencies: [
                "Providers",
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
                "Providers",
                "QuizFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "ExamsClient",
            dependencies: [
                "SharedModels",
                "Helpers",
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "Services",
            dependencies: [
                "SharedModels",
                "Helpers",
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "ExamsListFeature",
            dependencies: [
                "CoreDataClient",
                "CoreUI",
                "ExamDetailFeature",
                "SharedModels",
                "Services",
                "UserSettingsClient",
                "SharedViews",
            ]
        ),
        .target(
            name: "Extensions",
            dependencies: []
        ),
        .target(
            name: "FeatureFlagClient",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "LaunchDarkly", package: "ios-client-sdk"),
            ]

        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                "FeatureFlagClient",
                "SharedViews",
                "SharedModels",
                "MainMenuFeature",
                "SettingsFeature",
                .product(name: "LifetimeTracker", package: "LifetimeTracker"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "HomeFeatureTest",
            dependencies: [
                "HomeFeature",
                "Providers",
                "TestExtensions",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "Helpers",
            dependencies: [
                "Extensions",
            ]
        ),
        .target(
            name: "MainMenuFeature",
            dependencies: [
                "SharedViews",
                "SharedModels",
                "ExamDetailFeature",
                "FeatureFlagClient",
                "Providers",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "OnboardingFeature",
            dependencies: [
                "CoreUI",
                "SharedViews",
                "ExamsListFeature",
                "Providers",
                "UserSettingsClient",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "Providers",
            dependencies: []
        ),
        .target(
            name: "SharedModels",
            dependencies: [
                .product(name: "Difference", package: "Difference"),
                .product(name: "LifetimeTracker", package: "LifetimeTracker"),
            ]
        ),
        .target(
            name: "SharedViews",
            dependencies: [
                .product(name: "Inject", package: "Inject"),
            ]
        ),
        .target(
            name: "SettingsFeature",
            dependencies: [
                "CoreDataClient",
                "CoreUI",
                "CurrentQuizClient",
                "DiagnosticClient",
                "Providers",
                "SharedViews",
                "SharedModels",
                "UserSettingsClient",
                "UIApplicationClient",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "UserSettingsClient",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "UIApplicationClient",
            dependencies: [
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
            name: "QuizFeature",
            dependencies: [
                "CoreDataClient",
                "CurrentQuizClient",
                "CoreUI",
                "Providers",
                "SharedViews",
                "SharedModels",
                "Services",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "QuizFeatureTest",
            dependencies: [
                "QuizFeature",
                "TestExtensions",
                "SharedModels",
                "CoreUI",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
    ]
)

package.targets = package.targets.map { target in
    var plugins = target.plugins ?? []
    plugins.append(.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins"))
    target.plugins = plugins
    return target
}

extension Product {
    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, targets: [name])
    }
}
