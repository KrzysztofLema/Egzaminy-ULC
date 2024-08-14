import ComposableArchitecture
import Foundation
import SharedModels

@Reducer
public struct Quiz {
    @ObservableState
    public struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        var answers: IdentifiedArrayOf<AnswerFeature.State> = []
        var isNextButtonEnabled = false
        var presentedQuestionNumber: Int = 0
        var selectedAnswer: AnswerFeature.State?
        var questions: IdentifiedArrayOf<Question> = []

        public init(questions: [Question]) {
            self.questions = IdentifiedArrayOf(uniqueElements: questions)
        }
    }

    public enum Action: ViewAction, Equatable {
        @CasePathable
        public enum View: Equatable {
            case onViewLoad
            case nextQuestionButtonTapped
            case closeQuizButtonTapped
        }

        @CasePathable
        public enum Alert {
            case confirmCorrect
            case confirmNotCorrect
        }

        case alert(PresentationAction<Alert>)
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
            case .alert(.presented(.confirmCorrect)):
                state.presentedQuestionNumber += 1
                state.selectedAnswer = nil
                let answers = state.questions[state.presentedQuestionNumber].answers.map {
                    AnswerFeature.State(
                        id: uuid(),
                        answer: $0
                    )
                }
                state.answers.removeAll()
                state.answers.append(contentsOf: answers)

                state.isNextButtonEnabled = state.selectedAnswer != nil

                return .none
            case .alert(.presented(.confirmNotCorrect)):
                return .none
            case .alert(.dismiss):
                return .none
            case .nextQuestion:
                state.alert = .nextQuestion(isAnswerCorrect: state.selectedAnswer?.answer.isCorrect ?? false)
                return .none
            case let .answers(answerAction):
                switch answerAction {
                case let .element(id: _, action: .delegate(.didSelectionChanged(answer))):
                    state.selectedAnswer = answer

                    state.answers.indices.forEach { index in
                        state.answers[index].isSelected = state.answers[index].id == state.selectedAnswer?.id
                    }

                    state.isNextButtonEnabled = state.selectedAnswer != nil

                    return .none
                default:
                    return .none
                }
            case .selectedAnswer:
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
                return .run { send in
                    await send(.nextQuestion)
                }
            case .view(.closeQuizButtonTapped):
                return .run { _ in
                    await dismiss()
                }
            }
        }
        .forEach(\.answers, action: \.answers) {
            AnswerFeature()
        }
        .ifLet(\.$alert, action: \.alert)
    }

    public init() {}
}

extension AlertState where Action == Quiz.Action.Alert {
    static func nextQuestion(isAnswerCorrect: Bool) -> Self {
        if isAnswerCorrect {
            Self {
                TextState("Odpowiedź jest poprawna!")
            } actions: {
                ButtonState(action: .confirmCorrect) {
                    TextState("OK")
                }
            }
        } else {
            Self {
                TextState("Odpowiedź jest niepoprawna")
            } actions: {
                ButtonState {
                    TextState("OK")
                }
            }
        }
    }
}
