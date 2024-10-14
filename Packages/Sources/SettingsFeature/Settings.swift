import ComposableArchitecture
import CoreDataClient
import CurrentQuizClient
import DiagnosticClient
import Providers
import SharedModels
import UserSettingsClient

@Reducer
public struct Settings {
    @ObservableState
    public struct State: Equatable {
        public var appVersion: DiagnosticItem
        @Presents var alert: AlertState<Action.Alert>?
        var path = StackState<Path.State>()

        @Shared(.userSettings) var userSettings
        @Shared(.currentQuizState) var currentQuizState

        public init() {
            @Dependency(\.diagnosticClient) var diagnosticClient
            appVersion = diagnosticClient.appVersion()
        }
    }

    public enum Action: ViewAction {
        case alert(PresentationAction<Alert>)
        case path(StackAction<Path.State, Path.Action>)
        case view(View)

        @CasePathable
        public enum Alert: Equatable {
            case resetProgressAllSubjects
        }

        @CasePathable
        public enum View: Equatable {
            case appearanceButtonTapped
            case chooseSubjectButtonTapped
            case resetAllSubjectsProgressButtonTapped
        }
    }

    @Reducer(state: .equatable)
    public enum Path {
        case appearance(AppearanceFeature)
    }

    @Dependency(\.mainQueue) var mainQueue
    @Dependency(\.applicationClient) var applicationClient
    @Dependency(\.coreData) var coreData

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .view(.resetAllSubjectsProgressButtonTapped):
                state.alert = .resetProgressConfirmation
                return .none
            case .alert(.presented(.resetProgressAllSubjects)):
                state.currentQuizState.currentProgress.removeAll()
                return .none
            case .alert(.dismiss):
                return .none
            case .view(.appearanceButtonTapped):
                state.path.append(.appearance(.init()))
                return .none
            case .path:
                return .none
            case .view(.chooseSubjectButtonTapped):
                state.userSettings.applicationState = .onboarding
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$alert, action: \.alert)
    }

    public init() {}
}

extension AlertState where Action == Settings.Action.Alert {
    static let resetProgressConfirmation = AlertState {
        TextState("\(LocalizationProvider.SettingsResetAlert.resetAreYouSure)")
    } actions: {
        ButtonState(role: .destructive, action: .resetProgressAllSubjects) {
            TextState("\(LocalizationProvider.SettingsResetAlert.resetProgress)")
        }

        ButtonState(role: .cancel) {
            TextState("\(LocalizationProvider.SettingsResetAlert.cancelResetProgress)")
        }
    } message: {
        TextState("\(LocalizationProvider.SettingsResetAlert.cannotReversedInfo)")
    }
}
