import ComposableArchitecture
import CoreDataClient
import DiagnosticClient
import SharedModels
import UIApplicationClient
import UserSettingsClient

@Reducer
public struct Settings {
    @ObservableState
    public struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        public var userSettings: UserSettings
        public var appVersion: DiagnosticItem

        public init() {
            @Dependency(\.userSettings) var userSettings
            @Dependency(\.diagnosticClient) var diagnosticClient
            self.userSettings = userSettings.get()
            appVersion = diagnosticClient.appVersion()
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case task
        case resetAllSubjectsProgressButtonTapped
        case alert(PresentationAction<Alert>)
        case resetAllSubjects(Result<Void, Error>)

        @CasePathable
        public enum Alert: Equatable {
            case resetProgressAllSubjects
        }
    }

    @Dependency(\.userSettings) var userSettings
    @Dependency(\.mainQueue) var mainQueue
    @Dependency(\.applicationClient) var applicationClient
    @Dependency(\.coreData) var coreData

    public var body: some ReducerOf<Self> {
        CombineReducers {
            BindingReducer()
                .onChange(of: \.userSettings.colorScheme) { _, colorScheme in
                    Reduce { _, _ in
                        .run { _ in
                            await applicationClient.setUserInterfaceStyle(colorScheme.userInterfaceStyle)
                        }
                    }
                }

            Reduce { state, action in
                switch action {
                case .binding:
                    return .none
                case .task:
                    return .none
                case .resetAllSubjectsProgressButtonTapped:
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
                }
            }
        }
        .onChange(of: \.userSettings) { _, userSettings in
            Reduce { _, _ in
                .run { _ in
                    self.userSettings.set(userSettings)
                }
            }
        }
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
