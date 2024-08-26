import ComposableArchitecture
import UIApplicationClient
import UserSettingsClient

@Reducer
public struct Settings {
    @ObservableState
    public struct State: Equatable {
        public var userSettings: UserSettings

        public init() {
            @Dependency(\.userSettings) var userSettings
            self.userSettings = userSettings.get()
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case task
    }

    @Dependency(\.userSettings) var userSettings
    @Dependency(\.mainQueue) var mainQueue
    @Dependency(\.applicationClient) var applicationClient

    public var body: some ReducerOf<Self> {
        CombineReducers {
            BindingReducer()
                .onChange(of: \.userSettings.colorScheme) { _, colorScheme in
                    Reduce { _, _ in
                        .run { _ in
                            await applicationClient.setUserInterfaceStyle(colorScheme.userInterfaceStyle)
                        }
                    }
                }

            Reduce { _, action in
                switch action {
                default:
                    return .none
                }
            }
        }
        .onChange(of: \.userSettings) { _, userSettings in
            Reduce { _, _ in

                .run { _ in await self.userSettings.set(userSettings) }
            }
        }
    }

    public init() {}
}
