import ComposableArchitecture
import SharedModels
import UIKit

public enum ApplicationState: Codable, Equatable {
    case onboarding
    case home(Exam.ID)
}

public struct UserSettings: Equatable, Codable {
    public var colorScheme: ColorScheme
    public var applicationState: ApplicationState

    public enum ColorScheme: String, Codable, CaseIterable, Equatable, Identifiable {
        case light
        case dark
        case system

        public var id: String { rawValue }

        public var userInterfaceStyle: UIUserInterfaceStyle {
            switch self {
            case .dark:
                return .dark
            case .light:
                return .light
            case .system:
                return .unspecified
            }
        }
    }

    public init(
        colorScheme: UserSettings.ColorScheme = .system,
        applicationState: ApplicationState = .onboarding
    ) {
        self.colorScheme = colorScheme
        self.applicationState = applicationState
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        colorScheme = (try? container.decode(ColorScheme.self, forKey: .colorScheme)) ?? .system
        applicationState = (try? container.decode(ApplicationState.self, forKey: .applicationState)) ?? .onboarding
    }
}

extension URL {
    public static let userSettings = Self.documentsDirectory
        .appendingPathComponent("user-settings")
        .appendingPathExtension("json")
}
