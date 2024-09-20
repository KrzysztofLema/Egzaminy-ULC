import Foundation

public enum Configuration {
    public enum App {
        public static var version: String {
            Bundle.main.string(for: "CFBundleShortVersionString") ?? ""
        }

        public static var build: String {
            Bundle.main.string(for: "CFBundleVersion") ?? ""
        }

        public static var versionWithBuild: String {
            "\(version) (\(build))"
        }
    }
}

private extension Bundle {
    func string(for key: String) -> String? {
        object(forInfoDictionaryKey: key) as? String
    }
}
