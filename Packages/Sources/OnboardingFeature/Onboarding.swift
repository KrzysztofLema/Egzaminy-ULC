import ComposableArchitecture
import ExamsListFeature
import UserSettingsClient

@Reducer
public struct Onboarding {
    @ObservableState
    public struct State: Equatable {
        public var onboardingSteps: OnboardingSteps = .welcome
        public var examsList: ExamsList.State

        public init(
            examsList: ExamsList.State = ExamsList.State(),
            onboardingSteps: OnboardingSteps
        ) {
            self.examsList = examsList
            self.onboardingSteps = onboardingSteps
        }
    }

    public enum Action: ViewAction {
        @CasePathable
        public enum View {
            case nextButtonTapped
        }

        case examsList(ExamsList.Action)
        case view(View)
    }

    public var body: some ReducerOf<Self> {
        Scope(state: \.examsList, action: \.examsList) {
            ExamsList()
        }

        Reduce<State, Action> { state, action in
            switch action {
            case .view(.nextButtonTapped):
                state.onboardingSteps.next()
                return .none
            case .examsList:
                return .none
            }
        }
    }

    public init() {}
}

extension Onboarding.State {
    var isNextButtonVisible: Bool {
        !onboardingSteps.isLast()
    }
}
