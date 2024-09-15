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
            @Dependency(\.coreData) var coreData

            do {
                let subjects = try coreData.fetchAllSubjects()
                self.subjects = IdentifiedArrayOf(uniqueElements: subjects.map { SubjectFeature.State(id: UUID(), subject: $0) })
            } catch {}
        }
    }

    public enum Action: ViewAction {
        case alert(PresentationAction<Alert>)
        case destination(PresentationAction<Destination.Action>)
        case subjects(IdentifiedActionOf<SubjectFeature>)
        case shouldPresentQuiz(Bool, Subject)
        case view(View)

        @CasePathable
        public enum View {
            case presentQuizSubjectButtonTapped(Subject)
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

    @Dependency(\.uuid) var uuid
    @Dependency(\.coreData) var coreData

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
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
                // TODO: Reset subject progress
                return .none
            case .alert:
                return .none
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
