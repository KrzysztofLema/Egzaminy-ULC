import Dependencies

public struct FeatureFlagClient {
    public var boolFlag: @Sendable (String, Bool) -> Bool
    public var stringFlag: @Sendable (String, String) -> String
}

extension FeatureFlagClient: DependencyKey {
    public static var liveValue: FeatureFlagClient {
        Self(boolFlag: { key, defaultValue in
            FeatureFlagProvider.boolVariation(forKey: key, defaultValue: defaultValue)
        }, stringFlag: { key, defaultValue in
            FeatureFlagProvider.stringVariation(forKey: key, defaultValue: defaultValue)
        })
    }
}

extension DependencyValues {
    public var featureFlags: FeatureFlagClient {
        get { self[FeatureFlagClient.self] }
        set { self[FeatureFlagClient.self] = newValue }
    }
}
