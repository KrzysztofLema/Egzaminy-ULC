import ComposableArchitecture
import CoreDataClient
import Foundation
import SharedModels
import UserSettingsClient

@Reducer
public struct ExamsList {
    @ObservableState
    public struct State: Equatable {
        var exams: IdentifiedArrayOf<Exam> = []
        @Shared(.userSettings) public var userSettings: UserSettings
        public init() {
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
    }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .examDetailButtonTapped(exam):
                state.userSettings.applicationState = .home(exam.id)
                return .none
            }
        }
    }

    public init() {}
}
