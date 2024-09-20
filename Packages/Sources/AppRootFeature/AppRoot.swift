import ComposableArchitecture
import ExamDetailFeature
import Foundation
import HomeFeature

@Reducer
public struct AppRoot {
    @ObservableState
    public struct State {
        public var appDelegate: AppDelegateReducer.State
        var home: Home.State

        public init(
            appDelegate: AppDelegateReducer.State = AppDelegateReducer.State(),
            home: Home.State = Home.State()
        ) {
            self.appDelegate = appDelegate
            self.home = home
        }
    }

    public enum Action {
        case home(Home.Action)
        case appDelegate(AppDelegateReducer.Action)
    }

    public var body: some ReducerOf<Self> {
        Scope(
            state: \.appDelegate,
            action: \.appDelegate
        ) {
            AppDelegateReducer()
        }

        Scope(
            state: \.home,
            action: \.home
        ) {
            Home()
        }

        Reduce<State, Action> { _, action in
            switch action {
            case .home:
                return .none
            case .appDelegate:
                return .none
            }
        }
    }

    public init() {}
}
