import ComposableArchitecture

extension PersistenceKey where Self == PersistenceKeyDefault<FileStorageKey<UserSettings>> {
    public static var userSettings: Self {
        PersistenceKeyDefault(.fileStorage(.userSettings), UserSettings())
    }
}

public struct State {
    @Shared(.userSettings) var userSettings
}
