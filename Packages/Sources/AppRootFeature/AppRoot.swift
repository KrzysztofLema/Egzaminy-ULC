import ComposableArchitecture
import ExamDetailFeature
import Foundation
import HomeFeature
import OnboardingFeature
import UserSettingsClient

@Reducer
public struct AppRoot {
    @ObservableState
    public struct State {
        @Shared(.userSettings) public var userSettings

        public var appDelegate: AppDelegateReducer.State
        public var home: Home.State
        public var onboarding: Onboarding.State

        public init(
            appDelegate: AppDelegateReducer.State = AppDelegateReducer.State(),
            home: Home.State = Home.State(),
            onboarding: Onboarding.State = Onboarding.State(onboardingSteps: .welcome)
        ) {
            self.appDelegate = appDelegate
            self.home = home
            self.onboarding = onboarding
        }
    }

    public enum Action: BindableAction {
        case appDelegate(AppDelegateReducer.Action)
        case binding(BindingAction<State>)
        case home(Home.Action)
        case onboarding(Onboarding.Action)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()

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

        Scope(
            state: \.onboarding,
            action: \.onboarding
        ) {
            Onboarding()
        }
    }

    public init() {}
}
