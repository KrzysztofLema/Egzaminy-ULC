import ComposableArchitecture
import Foundation
import MainMenuFeature
import SettingsFeature

@Reducer
public struct Home {
    @ObservableState
    public struct State: Equatable {
        var selectedTab: Tab = .exams
        public var mainMenu: MainMenu.State
        public var settings: Settings.State

        public init(
            mainMenu: MainMenu.State = MainMenu.State(),
            settings: Settings.State = Settings.State()
        ) {
            self.mainMenu = mainMenu
            self.settings = settings
        }
    }

    public enum Action {
        case onTabSelection(Tab)
        case mainMenu(MainMenu.Action)
        case settings(Settings.Action)
    }

    public var body: some ReducerOf<Self> {
        Scope(state: \.mainMenu, action: \.mainMenu) {
            MainMenu()
        }

        Scope(state: \.settings, action: \.settings) {
            Settings()
        }

        Reduce<State, Action> { state, action in
            switch action {
            case let .onTabSelection(tab):
                state.mainMenu = MainMenu.State()
                state.selectedTab = tab
                return .none
            case .mainMenu:
                return .none
            case .settings:
                return .none
            }
        }
    }

    public init() {}
}

extension Home {
    public enum Tab: Equatable {
        case exams, settings
    }
}
