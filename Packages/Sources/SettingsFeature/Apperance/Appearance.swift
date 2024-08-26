import Inject
import SwiftUI
import UserSettingsClient

struct Appearance: View {
    @ObserveInjection private var iO
    @State private var selection: Int? = nil
    @Binding var colorScheme: UserSettings.ColorScheme

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
                        "Wybierając kolor aplikacji system, kolorystyka będzie zgodna z ustawieniami Twojego telefonu. Istnieje też możliwość wyboru wyglądu \"Jasnego\" bądź \"Ciemnego\"."
                    )
                }

                HStack(spacing: 25) {
                    ForEach(Array([UserSettings.ColorScheme.light, .dark, .system])) { colorScheme in
                        Button {
                            self.colorScheme = colorScheme
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
                                if colorScheme == self.colorScheme {
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
