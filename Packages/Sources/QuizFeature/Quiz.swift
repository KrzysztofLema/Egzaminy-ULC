import ComposableArchitecture
import Foundation
import SharedModels

@Reducer
public struct Quiz {
    @ObservableState
    public struct State: Equatable {
        var subject: Subject
        var presentedQuestion = 0

        public init(subject: Subject) {
            self.subject = subject
        }
    }

    public enum Action: Equatable {
        case nextQuestionButtonTapped
        case closeQuizButtonTapped
    }

    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .nextQuestionButtonTapped:
                state.presentedQuestion += 1
                return .none
            case .closeQuizButtonTapped:
                return .run { _ in
                    await dismiss()
                }
            }
        }
    }

    public init() {}
}
