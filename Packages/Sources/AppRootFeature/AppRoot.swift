import ComposableArchitecture
import ExamDetailFeature
import Foundation
import HomeFeature
import OnboardingFeature

@Reducer
public struct AppRoot {
    @Reducer(state: .equatable)
    public enum Destination {
        case onboarding(Onboarding)
    }

    @ObservableState
    public struct State {
        public var appDelegate: AppDelegateReducer.State
        @Presents public var destination: Destination.State?
        @Shared(.userSettings) public var userSettings
        var home: Home.State

        public init(
            appDelegate: AppDelegateReducer.State = AppDelegateReducer.State(),
            destination: Destination.State? = nil,
            home: Home.State = Home.State()
        ) {
            self.appDelegate = appDelegate
            self.destination = destination
            self.home = home
        }
    }

    public enum Action {
        case appDelegate(AppDelegateReducer.Action)
        case destination(PresentationAction<Destination.Action>)
        case home(Home.Action)
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

        Reduce<State, Action> { state, action in
            switch action {
            case .home:
                return .none
            case .appDelegate(.didFinishLaunching):
                if !state.userSettings.didFinishOnboarding {
                    state.destination = .onboarding(.init(onboardingSteps: .welcome))
                }

                return .none
            case .appDelegate:
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination.body
        }
    }

    public init() {}
}
