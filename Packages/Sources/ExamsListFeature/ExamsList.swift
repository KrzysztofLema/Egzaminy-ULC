import ComposableArchitecture
import CoreDataClient
import Foundation
import SharedModels
import UserSettingsClient

public enum ExamsListViewState: Equatable {
    case failure
    case success(exams: IdentifiedArrayOf<Exam>)
    case inProgress
    case initial
}

@Reducer
public struct ExamsList {
    @ObservableState
    public struct State: Equatable {
        public var examsListViewState: ExamsListViewState = .initial

        @Shared(.userSettings) public var userSettings: UserSettings

        public init() {
            @Dependency(\.coreData) var coreData

            coreData.saveExams()
        }
    }

    public enum Action {
        case examDetailButtonTapped(Exam)
        case didFetchExams(Result<[Exam], Error>)
        case onViewDidLoad
        case closeButtonTapped
    }

    @Dependency(\.coreData) var coreData
    @Dependency(\.dismiss) var dismiss

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .examDetailButtonTapped(exam):
                state.userSettings.applicationState = .home(exam.id)
                return .none
            case .onViewDidLoad:
                state.examsListViewState = .inProgress

                return .run { send in
                    await send(.didFetchExams(Result { try coreData.fetchAllExams() }))
                }
            case let .didFetchExams(.success(exams)):
                state.examsListViewState = .success(exams: IdentifiedArray(uniqueElements: exams))
                return .none

            case .didFetchExams(.failure):
                state.examsListViewState = .failure
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
