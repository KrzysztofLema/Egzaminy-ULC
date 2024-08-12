import ComposableArchitecture
import ExamDetailFeature
import Foundation
import SharedModels

@Reducer
public struct ExamsList {
    @ObservableState
    public struct State {
        var exams: [Exam] = ExamMock.mock
        public var path = StackState<Path.State>()

        public init() {}
    }

    public enum Action {
        case examDetailButtonTapped(Exam)
        case path(StackAction<Path.State, Path.Action>)
    }

    @Reducer(state: .equatable)
    public enum Path {
        case examDetailView(ExamDetail)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .examDetailButtonTapped(exam):
                state.path.append(.examDetailView(.init(exam: exam)))
                return .none
            case let .path(.element(id: _, action: .examDetailView(exam))):

                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

    public init() {}
}
