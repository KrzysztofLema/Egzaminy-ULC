import ComposableArchitecture
import CoreDataClient
import Foundation
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
        var currentQuestion: Question?

        public init(id: UUID, subject: Subject) {
            self.id = id
            self.subject = subject
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

        @CasePathable
        public enum Delegate: Equatable {
            case updateCurrentProgress(String, Int)
        }

        case delegate(Delegate)
        case alert(PresentationAction<Alert>)
        case nextQuestion
        case selectedAnswer(AnswerFeature.Action)
        case view(View)
        case answers(IdentifiedActionOf<AnswerFeature>)
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.uuid) var uuid
    @Dependency(\.coreData) var coreData

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert(.presented(.confirmCorrect)):
                let lastIndex = state.subject.questions?.count ?? 0 - 1
                guard let currentProgress = state.subject.currentProgress, currentProgress < lastIndex else {
                    state.subject.currentProgress = state.subject.questions?.count
                    return .run { _ in
                        await dismiss()
                    }
                }

                state.subject.currentProgress! += 1
                do {
                    let currentQuestion = try coreData.fetchQuestion(state.subject.currentProgress ?? 0)
                    state.currentQuestion = currentQuestion
                } catch {
                    return .none
                }

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
                guard let currentProgress = state.subject.currentProgress else {
                    return .none
                }

                do {
                    let currentQuestion = try coreData.fetchQuestion(state.subject.currentProgress ?? 0)
                    state.currentQuestion = currentQuestion
                    let answers = try coreData.fetchAllAnswers(state.currentQuestion?.order ?? 0).map {
                        AnswerFeature.State(
                            id: uuid(),
                            answer: $0
                        )
                    }

                    state.answers.append(contentsOf: answers)
                } catch {}

                return .none
            case .view(.nextQuestionButtonTapped):
                return .run { send in
                    await send(.nextQuestion)
                }
            case .view(.closeQuizButtonTapped):
                return .run { _ in
                    await dismiss()
                }
            case .delegate:
                return .none
            }
        }
        .forEach(\.answers, action: \.answers) {
            AnswerFeature()
        }
        .ifLet(\.$alert, action: \.alert)
        .onChange(of: \.subject.currentProgress) { _, newValue in
            Reduce { state, _ in
                guard let subjectID = state.subject.id, let newValue else {
                    return .none
                }
                return .send(.delegate(.updateCurrentProgress(subjectID, newValue)))
            }
        }
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
