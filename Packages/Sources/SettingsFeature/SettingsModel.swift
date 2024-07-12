import Foundation
import SharedModels

@Observable
public class SettingsModel {
    enum Subscreen: String, Identifiable, CaseIterable {
        case settings
        case roadmap
        case licenses
        case betaSettings

        var id: String { rawValue }

        var displayString: String {
            switch self {
            case .licenses:
                "Third Party Licenses"
            case .settings:
                "Settings"
            case .betaSettings:
                "Beta Settings"
            case .roadmap:
                "Roadmap"
            }
        }
    }

    var subscreen: Subscreen?
    public var betaSettings: BetaSettings = .init()

    public init() {}
}
