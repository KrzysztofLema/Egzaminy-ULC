import ComposableArchitecture
import ExamDetailFeature
import UserSettingsClient

@Reducer
public struct MainMenu {
    @ObservableState
    public struct State: Equatable {
        var path = StackState<Path.State>()

        public init() {}
    }

    public enum Action: ViewAction {
        case path(StackAction<Path.State, Path.Action>)
        case view(View)

        @CasePathable
        public enum View: Equatable {
            case didTapQuizButton
        }
    }

    @Reducer(state: .equatable)
    public enum Path {
        case examDetail(ExamDetail)
    }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .view(.didTapQuizButton):
                @Shared(.userSettings) var userSettings
                if case let .home(examID) = userSettings.applicationState {
                    state.path.append(.examDetail(.init(examID: examID)))
                }
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

    public init() {}
}
