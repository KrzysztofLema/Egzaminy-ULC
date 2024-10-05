import ComposableArchitecture
import CoreDataClient
import CurrentQuizClient
import Foundation
import QuizFeature
import SharedModels

@Reducer
public struct ExamDetail {
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?
        @Presents var alert: AlertState<Action.Alert>?
        @Shared(.currentQuizState) public var currentQuizState

        let examID: Exam.ID
        var exam: Exam?
        var subjects: IdentifiedArrayOf<SubjectFeature.State> = []

        public init(examID: Exam.ID, destination: Destination.State? = nil) {
            self.examID = examID
            self.destination = destination
        }
    }

    @Dependency(\.uuid) var uuid
    @Dependency(\.coreData) var coreData

    public enum Action: ViewAction {
        case alert(PresentationAction<Alert>)
        case destination(PresentationAction<Destination.Action>)
        case fetchExam(Result<Exam, Error>)
        case subjects(IdentifiedActionOf<SubjectFeature>)
        case shouldPresentQuiz(Bool, Subject)
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
            case let .view(.presentQuizSubjectButtonTapped(subject)):
                let lastIndex = (subject.questions?.count ?? 0) - 1
                let isLastQuestion = state.currentQuizState.currentProgress[subject.id, default: 0] <= lastIndex
                return .run { send in
                    await send(.shouldPresentQuiz(isLastQuestion, subject))
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
                state.currentQuizState.currentProgress.removeValue(forKey: subject.id)
                return .none
            case .alert:
                return .none
            case let .fetchExam(.success(exam)):
                state.exam = exam
                state.subjects = IdentifiedArrayOf(uniqueElements: exam.subjects.map { SubjectFeature.State(id: UUID(), subject: $0) })
                return .none
            case let .fetchExam(.failure):
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
        .run { [examID = state.examID] send in
            await send(.fetchExam(Result {
                try coreData.fetchExamByID(examID)
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
