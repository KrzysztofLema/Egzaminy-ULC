import ComposableArchitecture
import Foundation
import SharedModels

@Reducer
public struct Quiz {
    @ObservableState
    public struct State: Equatable {
        var presentedQuestionNumber: Int = 0
        var selectedAnswerID: UUID? = nil
        var questions: IdentifiedArrayOf<Question> = []
        var answers: IdentifiedArrayOf<AnswerFeature.State> = []
        var selectedAnswer: AnswerFeature.State? = nil

        public init(questions: [Question]) {
            self.questions = IdentifiedArrayOf(uniqueElements: questions)
        }
    }

    public enum Action: ViewAction, Equatable {
        public enum View: Equatable {
            case onViewLoad
            case nextQuestionButtonTapped
            case closeQuizButtonTapped
        }

        case didSelectAnswer
        case nextQuestion
        case selectedAnswer(AnswerFeature.Action)
        case view(View)
        case answers(IdentifiedActionOf<AnswerFeature>)
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.uuid) var uuid

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didSelectAnswer:
                return .none
            case .view(.onViewLoad):
                let answers = state.questions[state.presentedQuestionNumber].answers.map {
                    AnswerFeature.State(
                        id: uuid(),
                        answer: $0
                    )
                }
                state.answers.append(contentsOf: answers)
                return .none
            case .view(.nextQuestionButtonTapped):
                state.presentedQuestionNumber += 1
                return .run { _ in
                }
            case .view(.closeQuizButtonTapped):
                return .run { _ in
                    await dismiss()
                }
            case .nextQuestion:
                state.presentedQuestionNumber += 1
                return .none
            case let .answers(answerAction):
                switch answerAction {
                case let .element(id: _, action: .delegate(.didSelectionChanged(answer))):
                    state.selectedAnswer = answer

                    state.answers.indices.forEach { int in
                        state.answers[int].isSelected = state.answers[int].id == state.selectedAnswer?.id
                    }

                    return .run { send in
                        await send(.didSelectAnswer)
                    }
                default:
                    return .none
                }
            case .selectedAnswer:
                return .none
            }
        }
        .forEach(\.answers, action: \.answers) {
            AnswerFeature()
        }
    }

    public init() {}
}
