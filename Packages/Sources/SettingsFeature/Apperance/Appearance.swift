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

                HStack {
                    ForEach(Array([UserSettings.ColorScheme.light, .dark, .system])) { colorScheme in
                        Button {
                            send(.colorSchemeButtonTapped(colorScheme))
                        } label: {
                            VStack {
                                colorScheme.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))

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
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
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

    fileprivate var image: Image {
        switch self {
        case .dark:
            return Image("DarkMode")
        case .light:
            return Image("LightMode")
        case .system:
            return Image("SystemMode")
        }
    }
}
