import Extensions
import Foundation

public enum PlistConfiguration {
    public enum API {
        public static var scheme: String {
            Bundle.main.string(for: "API_SCHEME")
        }

        public static var host: String {
            Bundle.main.string(for: "API_HOST")
        }

        public static var path: String {
            Bundle.main.string(for: "API_PATH")
        }

        public static var auth_secret: String {
            Bundle.main.string(for: "AUTH_SECRET")
        }

        public static var currentApiURL: URL? {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            return components.url
        }
    }

    public enum App {
        public static var build: String {
            Bundle.main.string(for: "CFBundleVersion")
        }

        public static var currentSchemeName: String {
            Bundle.main.string(for: "CURRENT_SCHEME_NAME")
        }

        public static var versionWithBuild: String {
            "\(version) (\(build))"
        }

        public static var version: String {
            Bundle.main.string(for: "CFBundleShortVersionString")
        }

        public static var supportedVersion: String {
            "\(build).0"
        }

        public static var useMockData: Bool {
            Bundle.main.string(for: "USE_MOCK_DATA") == "YES"
        }

        public static var launchDarklyMobKey: String {
            Bundle.main.string(for: "LAUNCH_DARKLY_MOB_KEY")
        }

        public static var launchDarklyContextKey: String {
            Bundle.main.string(for: "LAUNCH_DARKLY_CONTEXT_KEY")
        }
    }
}
