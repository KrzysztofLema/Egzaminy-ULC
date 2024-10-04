import ComposableArchitecture
import UIKit

public struct UserSettings: Equatable, Codable {
    public var colorScheme: ColorScheme
    public var didFinishOnboarding: Bool

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
        didFinishOnboarding: Bool = false
    ) {
        self.colorScheme = colorScheme
        self.didFinishOnboarding = didFinishOnboarding
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        colorScheme = (try? container.decode(ColorScheme.self, forKey: .colorScheme)) ?? .system
        didFinishOnboarding = (try? container.decode(Bool.self, forKey: .didFinishOnboarding)) ?? false
    }
}

extension URL {
    public static let userSettings = Self.documentsDirectory
        .appendingPathComponent("user-settings")
        .appendingPathExtension("json")
}
