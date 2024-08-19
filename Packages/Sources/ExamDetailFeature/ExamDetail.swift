import ComposableArchitecture
import Foundation
import QuizFeature
import SharedModels

@Reducer
public struct ExamDetail {
    @ObservableState
    public struct State: Equatable {
        @Presents var destination: Destination.State?
        let exam: Exam
        var subjects: IdentifiedArrayOf<SubjectFeature.State> = []

        public init(exam: Exam, destination: Destination.State? = nil) {
            self.exam = exam
            self.destination = destination
            subjects = IdentifiedArrayOf(uniqueElements: exam.subjects.map { SubjectFeature.State(id: UUID(), subject: $0) })
        }
    }

    public enum Action: ViewAction, Equatable {
        case destination(PresentationAction<Destination.Action>)
        case view(View)
        case subjects(IdentifiedActionOf<SubjectFeature>)

        @CasePathable
        public enum View: Equatable {
            case presentQuizSubjectButtonTapped(Subject)
        }
    }

    @Reducer
    public struct Destination {
        @ObservableState
        public enum State: Equatable {
            case presentQuiz(Quiz.State)
        }

        public enum Action: Equatable {
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
                state.destination = .presentQuiz(Quiz.State(id: uuid(), subject: subject))
                return .none
            case .subjects:
                return .none
            case .destination:
                return .none
            }
        }
        .forEach(\.subjects, action: \.subjects) {
            SubjectFeature()
        }

        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }

    public init() {}
}
