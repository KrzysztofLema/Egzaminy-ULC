import ComposableArchitecture
import Inject
import SwiftUI
import UIApplicationClient
import UserSettingsClient

@Reducer
public struct AppearanceFeature {
    @ObservableState
    public struct State: Equatable {
        @Shared(.userSettings) var userSettings
    }

    public enum Action: ViewAction {
        @CasePathable
        public enum View: Equatable {
            case colorSchemeButtonTapped(UserSettings.ColorScheme)
        }

        case view(View)
    }

    @Dependency(\.applicationClient) var applicationClient

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .view(.colorSchemeButtonTapped(colorScheme)):
                state.userSettings.colorScheme = colorScheme

                return .run { _ in
                    await applicationClient.setUserInterfaceStyle(colorScheme.userInterfaceStyle)
                }
            }
        }
    }
}

@ViewAction(for: AppearanceFeature.self)
struct Appearance: View {
    @ObserveInjection private var iO
    var store: StoreOf<AppearanceFeature>

    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            VStack(spacing: 60) {
                Text("Ustawienia Aplikacji")
                    .font(.title3.bold())
                VStack(alignment: .leading, spacing: 12) {
                    Text("Wygląd aplikacji")
                        .font(.callout.bold())

                    Text(
                        """
                        Wybierając kolor aplikacji system, kolorystyka będzie
                        zgodna z ustawieniami Twojego telefonu. Istnieje
                        też możliwość wyboru wyglądu \"Jasnego\" bądź \"Ciemnego\".
                        """
                    )
                }

                HStack(spacing: 25) {
                    ForEach(Array([UserSettings.ColorScheme.light, .dark, .system])) { colorScheme in
                        Button {
                            send(.colorSchemeButtonTapped(colorScheme))
                        } label: {
                            VStack {
                                if colorScheme != .system {
                                    Color(.lightGray)
                                        .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                } else {
                                    HStack(spacing: 0) {
                                        Color.gray
                                        Color.black
                                    }
                                    .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                }

                                Text(colorScheme.title)
                            }
                            .padding(5)
                            .overlay {
                                if store.userSettings.colorScheme == colorScheme {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .stroke(.blue, lineWidth: 3)
                                }
                            }
                        }
                    }
                }
                .frame(height: 160)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
        .enableInjection()
    }
}

extension UserSettings.ColorScheme {
    fileprivate var title: LocalizedStringKey {
        switch self {
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        case .system:
            return "System"
        }
    }
}
