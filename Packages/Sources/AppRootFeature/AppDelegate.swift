import ComposableArchitecture
import UserSettingsClient

@Reducer
public struct AppDelegateReducer {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case didFinishLaunching
    }

    @Dependency(\.applicationClient.setUserInterfaceStyle) var setUserInterfaceStyle

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { _, action in
            switch action {
            case .didFinishLaunching:
                return .run { _ in
                    await withThrowingTaskGroup(of: Void.self) { group in
                        group.addTask {
                            @Shared(.userSettings) var userSettings
                            await setUserInterfaceStyle(userSettings.colorScheme.userInterfaceStyle)
                        }
                    }
                }
            }
        }
    }
}
