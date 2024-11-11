import ComposableArchitecture
import ExamsListFeature
import UserSettingsClient

@Reducer
public struct Onboarding {
    @ObservableState
    public struct State: Equatable {
        var path = StackState<Path.State>()
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
        case path(StackAction<Path.State, Path.Action>)

        @CasePathable
        public enum View {
            case nextButtonTapped
        }

        case view(View)
    }

    @Reducer(state: .equatable)
    public enum Path {
        case examList(ExamsList)
    }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .view(.nextButtonTapped):
                if state.onboardingSteps.isLast() {
                    state.path.append(.examList(.init()))
                } else {
                    state.onboardingSteps.next()
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

extension Onboarding.State {
    var isNextButtonVisible: Bool {
        !onboardingSteps.isLast()
    }
}
