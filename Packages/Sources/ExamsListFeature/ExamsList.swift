import ComposableArchitecture
import CoreDataClient
import ExamDetailFeature
import Foundation
import SharedModels

@Reducer
public struct ExamsList {
    @ObservableState
    public struct State: Equatable {
        var exams: IdentifiedArrayOf<Exam> = []
        public var path: StackState<Path.State>

        public init(path: StackState<Path.State> = StackState<Path.State>()) {
            self.path = path

            @Dependency(\.coreData) var coreData

            do {
                try coreData.saveExams()

                let exams = try coreData.fetchAllExams()
                self.exams = IdentifiedArrayOf(uniqueElements: exams)
            } catch {
                // TODO: Error Handling
                exams = []
            }
        }
    }

    public enum Action {
        case examDetailButtonTapped(Exam)
        case path(StackAction<Path.State, Path.Action>)
        case resetAllSubjects
    }

    @Reducer(state: .equatable)
    public enum Path {
        case examDetailView(ExamDetail)
    }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .examDetailButtonTapped(exam):
                state.path.append(.examDetailView(.init(exam: exam)))
                return .none
            case .path:
                return .none
            case .resetAllSubjects:
                guard let examDetailIndex = state.path.firstIndex(where: { $0.is(\.examDetailView) }) else {
                    return .none
                }

                let examIndex = state.path.ids[examDetailIndex]

                return .run { send in
                    await send(.path(.element(id: examIndex, action: .examDetailView(.resetAllSubjects))))
                }
            }
        }
        .forEach(\.path, action: \.path)
    }

    public init() {}
}
