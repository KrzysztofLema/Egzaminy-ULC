import ComposableArchitecture
import ExamDetailFeature
import ExamsListFeature
import Foundation
import SettingsFeature

@Reducer
public struct Home {
    @ObservableState
    public struct State: Equatable {
        var selectedTab: Tab = .exams
        public var examsList: ExamsList.State
        public var settings: Settings.State

        public init(
            examsList: ExamsList.State = ExamsList.State(),
            settings: Settings.State = Settings.State()
        ) {
            self.examsList = examsList
            self.settings = settings
        }
    }

    public enum Action {
        case onTabSelection(Tab)
        case examsList(ExamsList.Action)
        case settings(Settings.Action)
    }

    public var body: some ReducerOf<Self> {
        Scope(state: \.examsList, action: \.examsList) {
            ExamsList()
        }

        Scope(state: \.settings, action: \.settings) {
            Settings()
        }

        Reduce<State, Action> { state, action in
            switch action {
            case let .onTabSelection(tab):
                state.selectedTab = tab
                return .none
            case .examsList:
                return .none
            case .settings:
                return .none
            }
        }
    }

    var examListReducer: some ReducerOf<Self> {
        Scope(state: \.examsList, action: \.examsList) {
            ExamsList()
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
