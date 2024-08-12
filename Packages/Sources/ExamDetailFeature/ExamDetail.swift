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

        public init(exam: Exam) {
            self.exam = exam
        }
    }

    public enum Action: ViewAction, Equatable {
        case destination(PresentationAction<Destination.Action>)
        case view(View)

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

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .destination:
                return .none
            case let .view(.presentQuizSubjectButtonTapped(subject)):
                state.destination = .presentQuiz(Quiz.State(subject: subject))
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }

    public init() {}
}
