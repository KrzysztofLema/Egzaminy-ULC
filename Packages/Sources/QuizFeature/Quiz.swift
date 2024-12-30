import ComposableArchitecture
import CoreDataClient
import CurrentQuizClient
import Foundation
import Services
import SharedModels

@Reducer
public struct Quiz {
    @ObservableState
    public struct State: Identifiable, Equatable {
        public let id: UUID
        var subject: Subject
        @Presents var alert: AlertState<Action.Alert>?
        var answers: IdentifiedArrayOf<AnswerFeature.State> = []
        var isNextButtonEnabled = false
        var selectedAnswer: AnswerFeature.State?
        var questions: [Question]?
        var currentQuestion: Question?
        @Shared(.currentQuizState) public var currentQuizState

        public init(id: UUID, subject: Subject, alert: AlertState<Action.Alert>? = nil) {
            self.id = id
            self.subject = subject
            self.alert = alert
        }
    }

    public enum Action: ViewAction {
        @CasePathable
        public enum View: Equatable {
            case onViewAppear
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
        case updateCurrentQuestion(Question)
        case getQuestions(Result<[Question], Error>)
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.uuid) var uuid
    @Dependency(\.questionsAPIClient) var questionsApiClient

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .alert(.presented(.confirmCorrect)):
                state.currentQuizState.currentProgress[state.subject.id, default: 0] += 1
                return .run { [subject = state.subject, questions = state.questions, currentProgress = state.currentQuizState.currentProgress] send in
                    let currentProgress = currentProgress[subject.id]
                    let currentQuestion = questions?[currentProgress ?? 0]
                    await send(.updateCurrentQuestion(currentQuestion!))
                }
            case .alert(.presented(.confirmNotCorrect)):
                return .none
            case .alert(.dismiss):
                return .none
            case .nextQuestion:
                state.alert = .nextQuestion(isAnswerCorrect: state.selectedAnswer?.answer.isCorrect ?? false)
                return .none
            case let .updateCurrentQuestion(question):
                state.currentQuestion = question
                state.selectedAnswer = nil

                let answers = state.currentQuestion?.answers?.map {
                    AnswerFeature.State(
                        id: uuid(),
                        answer: $0
                    )
                }

                state.answers.removeAll()
                state.answers.append(contentsOf: answers ?? [])

                state.isNextButtonEnabled = state.selectedAnswer != nil
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
            case .view(.onViewAppear):
                return .run { [subject = state.subject] send in
                    guard let id = subject.id else { return }
                    await send(.getQuestions(Result { try await questionsApiClient.fetchQuestions(id) }))
                }
            case .view(.nextQuestionButtonTapped):
                return .run { send in
                    await send(.nextQuestion)
                }
            case .view(.closeQuizButtonTapped):
                return .run { _ in
                    await dismiss()
                }
            case let .getQuestions(.success(questions)):
                state.questions = questions
                return .run { [questions = state.questions, subject = state.subject, currentProgressState = state.currentQuizState.currentProgress] send in
                    let currentProgress = currentProgressState[subject.id]
                    let currentQuestion = questions?[currentProgress ?? 0]
                    await send(.updateCurrentQuestion(currentQuestion!))
                }
            case .getQuestions(.failure):
                return .none
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
