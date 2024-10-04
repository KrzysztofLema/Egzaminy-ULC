import ComposableArchitecture
import UserSettingsClient

@Reducer
public struct Onboarding {
    @ObservableState
    public struct State: Equatable {
        public var onboardingSteps: OnboardingSteps = .welcome
        @Shared(.userSettings) public var userSettings: UserSettings

        public init(onboardingSteps: OnboardingSteps) {
            self.onboardingSteps = onboardingSteps
        }
    }

    public enum Action: ViewAction {
        @CasePathable
        public enum View {
            case nextButtonTapped
        }

        case view(View)
    }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .view(.nextButtonTapped):
                if state.onboardingSteps.isLast() {
                    state.userSettings.didFinishOnboarding = true
                    return .none
                }
                state.onboardingSteps.next()
                return .none
            }
        }
    }

    public init() {}
}
