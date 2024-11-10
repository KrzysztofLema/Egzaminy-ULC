import LaunchDarkly

public enum FeatureFlagProvider {
    public static let bookmarksFeature = "bookmarks-feature-flag"
    public static let newOnboardingFlow = "new-onboarding-flow"
    public static let darkModeToggle = "dark-mode-toggle"
    public static let bookmarkIconFlag = "bookmark-icon-flag1"

    public static func boolVariation(forKey key: String, defaultValue: Bool) -> Bool {
        guard let client = LDClient.get() else {
            return defaultValue
        }

        if !client.isInitialized {
            return defaultValue
        }

        return client.boolVariation(forKey: key, defaultValue: defaultValue)
    }

    public static func stringVariation(forKey key: String, defaultValue: String) -> String {
        guard let client = LDClient.get() else {
            return defaultValue
        }

        if !client.isInitialized {
            return defaultValue
        }

        let result = client.stringVariation(forKey: key, defaultValue: defaultValue)
        return result
    }
}
