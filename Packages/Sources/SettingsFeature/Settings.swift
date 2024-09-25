import ComposableArchitecture
import CoreDataClient
import DiagnosticClient
import SharedModels
import UserSettingsClient

@Reducer
public struct Settings {
    @ObservableState
    public struct State: Equatable {
        public var appVersion: DiagnosticItem
        @Presents var alert: AlertState<Action.Alert>?
        var path = StackState<Path.State>()
        @Shared(.userSettings) var userSettings: UserSettings

        public init() {
            @Dependency(\.diagnosticClient) var diagnosticClient
            appVersion = diagnosticClient.appVersion()
        }
    }

    public enum Action: ViewAction {
        case alert(PresentationAction<Alert>)
        case resetAllSubjects(Result<Void, Error>)
        case path(StackAction<Path.State, Path.Action>)
        case view(View)

        @CasePathable
        public enum Alert: Equatable {
            case resetProgressAllSubjects
        }

        @CasePathable
        public enum View: Equatable {
            case settingsButtonTapped
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
                return .run { send in
                    await send(.resetAllSubjects(
                        Result { try coreData.resetAllSubjectsCurrentProgress() }
                    ))
                }
            case .alert(.dismiss):
                return .none
            case .resetAllSubjects:
                return .none
            case .view(.settingsButtonTapped):
                state.path.append(.appearance(.init()))
                return .none
            case .path:
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
        TextState("Czy napewno chcesz zresetować postęp we wszystkich Tematach?")
    } actions: {
        ButtonState(role: .destructive, action: .resetProgressAllSubjects) {
            TextState("Resetuj postęp")
        }

        ButtonState(role: .cancel) {
            TextState("Anuluj reset")
        }
    } message: {
        TextState("Tej operacji nie da się odwrócić.")
    }
}
