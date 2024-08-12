import ComposableArchitecture
import ExamDetailFeature
import Foundation
import HomeFeature

@Reducer
public struct AppRoot {
    @ObservableState
    public struct State {
        var home: Home.State
        public init(home: Home.State = Home.State()) {
            self.home = home
        }
    }

    public enum Action {
        case home(Home.Action)
    }

    public var body: some ReducerOf<Self> {
        Scope(
            state: \.home,
            action: \.home
        ) {
            Home()
        }

        Reduce { _, action in
            switch action {
            case .home:
                return .none
            }
        }
    }

    public init() {}
}
