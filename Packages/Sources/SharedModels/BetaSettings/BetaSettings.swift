import AutomaticSettings
import Foundation

public struct BetaSettings: AutomaticSettings, Codable {
    public struct Animations: AutomaticSettings, Codable {
        public enum Curve: String, Codable, CaseIterable, CustomStringConvertible {
            case linear
            case easeInOut
            case easeOut

            public var description: String {
                rawValue
            }
        }

        public var postOpeningSpeed: Double = 0.2
        public var postOpeningCurve: Curve = .easeInOut

        public init() {}
    }

    public var animations: Animations = .init()

    public init() {}
}

public class BetaSettingsExternalData: ObservableObject {
    public init() {}
}
