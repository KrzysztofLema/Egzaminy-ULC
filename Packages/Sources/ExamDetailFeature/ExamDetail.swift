import ComposableArchitecture
import CoreDataClient
import Foundation
import QuizFeature
import SharedModels

@Reducer
public struct ExamDetail {
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?
        @Presents var alert: AlertState<Action.Alert>?

        let exam: Exam
        var subjects: IdentifiedArrayOf<SubjectFeature.State> = []

        public init(exam: Exam, destination: Destination.State? = nil) {
            self.exam = exam
            self.destination = destination
        }
    }

    @Dependency(\.uuid) var uuid
    @Dependency(\.coreData) var coreData

    public enum Action: ViewAction {
        case alert(PresentationAction<Alert>)
        case destination(PresentationAction<Destination.Action>)
        case udateSubjectProgress(Result<Subject, Error>)
        case fetchSubjects(Result<[Subject], Error>)
        case subjects(IdentifiedActionOf<SubjectFeature>)
        case shouldPresentQuiz(Bool, Subject)
        case resetAllSubjects
        case view(View)

        @CasePathable
        public enum View {
            case presentQuizSubjectButtonTapped(Subject)
            case onViewAppear
        }

        @CasePathable
        public enum Alert: Equatable {
            case resetProgressInSubject(Subject)
        }
    }

    @Reducer
    public struct Destination {
        @ObservableState
        public enum State: Equatable {
            case presentQuiz(Quiz.State)
        }

        public enum Action {
            case presentQuiz(Quiz.Action)
        }

        public var body: some ReducerOf<Self> {
            Scope(state: \.presentQuiz, action: \.presentQuiz) {
                Quiz()
            }
        }

        public init() {}
    }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .destination(.presented(.presentQuiz(.delegate(action)))):
                switch action {
                case let .updateCurrentProgress(id, currentProgress):
                    if let index = state.subjects.firstIndex(where: { $0.subject.id == id }) {
                        state.subjects[index].subject.currentProgress = currentProgress
                    }
                    return .none
                }
            case let .view(.presentQuizSubjectButtonTapped(subject)):
                return .run { send in
                    await send(.shouldPresentQuiz(subject.isLastQuestion, subject))
                }

            case let .shouldPresentQuiz(false, subject):
                state.alert = .lastQuestionAlert(in: subject)
                return .none
            case let .shouldPresentQuiz(true, subject):
                state.destination = .presentQuiz(Quiz.State(id: uuid(), subject: subject))
                return .none
            case .subjects:
                return .none
            case .destination:
                return .none
            case let .alert(.presented(.resetProgressInSubject(subject))):
                return .run { send in
                    await send(.udateSubjectProgress(
                        Result {
                            try coreData.resetSubjectCurrentProgress(subject.id)
                        }
                    ))
                }
            case .alert:
                return .none
            case let .udateSubjectProgress(.success(subject)):
                if let index = state.subjects.firstIndex(where: { $0.subject.id == subject.id }) {
                    state.subjects[index].subject.currentProgress = subject.currentProgress
                }
                return .none
            case .udateSubjectProgress(.failure):
                return .none
            case .resetAllSubjects:
                return fetchAllSubjects(state: &state)
            case let .fetchSubjects(.success(subjects)):
                state.subjects = IdentifiedArrayOf(uniqueElements: subjects.map { SubjectFeature.State(id: UUID(), subject: $0) })
                return .none
            case .fetchSubjects(.failure):
                return .none
            case .view(.onViewAppear):
                return fetchAllSubjects(state: &state)
            }
        }
        .forEach(\.subjects, action: \.subjects) {
            SubjectFeature()
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
        .ifLet(\.$alert, action: \.alert)
    }

    func fetchAllSubjects(state: inout State) -> Effect<Action> {
        .run { send in
            await send(.fetchSubjects(Result {
                try coreData.fetchAllSubjects()
            }))
        }
    }

    public init() {}
}

extension AlertState where Action == ExamDetail.Action.Alert {
    static func lastQuestionAlert(in subject: Subject) -> Self {
        AlertState {
            TextState("To jest ostatnie pytanie w tym temacie. Czy chcesz zacząć od nowa?")
        } actions: {
            ButtonState(role: .destructive, action: .resetProgressInSubject(subject)) {
                TextState("Tak")
            }
            ButtonState(role: .cancel) {
                TextState("Nie")
            }
        } message: {
            TextState("Tego nie da się odwrócić!")
        }
    }
}
