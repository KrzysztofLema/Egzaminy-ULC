import Combine
import Dependencies
import Foundation

@dynamicMemberLookup
public struct UserSettingsClient {
    public var get: @Sendable () -> UserSettings
    public var set: @Sendable (UserSettings) -> Void
    public var stream: @Sendable () -> AsyncStream<UserSettings>

    public subscript<Value>(dynamicMember keyPath: KeyPath<UserSettings, Value>) -> Value {
        self.get()[keyPath: keyPath]
    }

    @_disfavoredOverload
    public subscript<Value>(
        dynamicMember keyPath: KeyPath<UserSettings, Value>
    ) -> AsyncStream<Value> {
        self.stream().map { $0[keyPath: keyPath] }.eraseToStream()
    }

    public func modify(_ operation: (inout UserSettings) -> Void) async {
        var userSettings = self.get()
        operation(&userSettings)
        await self.set(userSettings)
    }
}

extension UserSettingsClient: DependencyKey {
    public static var liveValue: UserSettingsClient {
        let initialUserSettingsData = (try? Data(contentsOf: .userSettings)) ?? Data()
        let initialUserSettings =
            (try? JSONDecoder().decode(UserSettings.self, from: initialUserSettingsData))
                ?? UserSettings()

        let userSettings = LockIsolated(initialUserSettings)
        let subject = PassthroughSubject<UserSettings, Never>()

        return Self(get: {
            userSettings.value
        }, set: { updatedSettings in
            userSettings.withValue {
                $0 = updatedSettings
                subject.send(updatedSettings)
                try? JSONEncoder().encode(updatedSettings).write(to: .userSettings)
            }
        }, stream: {
            subject.values.eraseToStream()
        })
    }
}

extension DependencyValues {
    public var userSettings: UserSettingsClient {
        get { self[UserSettingsClient.self] }
        set { self[UserSettingsClient.self] = newValue }
    }
}
