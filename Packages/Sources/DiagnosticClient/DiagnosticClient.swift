import Dependencies
import Foundation
import Providers
import SharedModels

public struct DiagnosticClient {
    public var appVersion: @Sendable () -> DiagnosticItem
}

extension DiagnosticClient: DependencyKey {
    public static var liveValue: DiagnosticClient {
        Self {
            let version = DiagnosticItem(
                title: "\(LocalizationProvider.Settings.appVersion): ",
                value: Configuration.App.versionWithBuild
            )
            return version
        }
    }
}

extension DiagnosticClient: TestDependencyKey {
    public static let testValue = Self {
        DiagnosticItem(title: "\(LocalizationProvider.Settings.appVersion)", value: "1.0")
    }
}

extension DependencyValues {
    public var diagnosticClient: DiagnosticClient {
        get { self[DiagnosticClient.self] }
        set { self[DiagnosticClient.self] = newValue }
    }
}
