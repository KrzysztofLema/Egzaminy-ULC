import ComposableArchitecture
import CoreDataClient
import Foundation
import Services
import SharedModels
import UserSettingsClient

@Reducer
public struct ExamsList {
    @ObservableState
    public struct State: Equatable {
        @Shared(.userSettings) public var userSettings: UserSettings

        public var isLoading: Bool = true
        public var errorOccured: Bool = false
        public var exams: IdentifiedArrayOf<Exam> = []

        public init() {}
    }

    public enum Action {
        case examDetailButtonTapped(Exam)
        case fetchExams(Result<[Exam], Error>)
        case task
        case closeButtonTapped
    }

    @Dependency(\.examsApiClient) var examsApiClient
    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .examDetailButtonTapped(exam):
                state.userSettings.applicationState = .home(exam.id)
                return .none
            case .task:
                return .run { send in
                    await withTaskGroup(of: Void.self) { group in
                        group.addTask {
                            await send(.fetchExams(Result {
                                try await examsApiClient.fetchExams()
                            }))
                        }
                    }
                }
            case let .fetchExams(.success(exams)):
                state.exams = IdentifiedArray(uniqueElements: exams)

                state.isLoading = false
                return .none
            case .fetchExams(.failure):
                state.isLoading = false
                state.errorOccured = true
                return .none
            case .closeButtonTapped:
                return .run { _ in
                    await dismiss()
                }
            }
        }
    }

    public init() {}
}
