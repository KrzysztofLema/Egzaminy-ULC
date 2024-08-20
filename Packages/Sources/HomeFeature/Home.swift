import ComposableArchitecture
import ExamDetailFeature
import ExamsListFeature
import Foundation

@Reducer
public struct Home {
    @ObservableState
    public struct State: Equatable {
        var selectedTab: Tab = .exams
        public var examsList: ExamsList.State

        public init(examsList: ExamsList.State = ExamsList.State()) {
            self.examsList = examsList
        }
    }

    public enum Action {
        case onTabSelection(Tab)
        case examsList(ExamsList.Action)
    }

    public var body: some ReducerOf<Self> {
        Scope(state: \.examsList, action: \.examsList) {
            ExamsList()
        }

        Reduce { state, action in
            switch action {
            case let .onTabSelection(tab):
                state.selectedTab = tab
                return .none
            case .examsList:
                return .none
            }
        }
    }

    public init() {}
}

extension Home {
    public enum Tab: Equatable {
        case exams, settings

        var title: String {
            switch self {
            case .exams: "Exams"
            case .settings: "Settins"
            }
        }
    }
}
