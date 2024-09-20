import ComposableArchitecture
import CoreUI
import SharedModels
import SharedViews
import SwiftUI

public struct SettingsView: View {
    @Bindable var store: StoreOf<Settings>

    var subscreen: Subscreen?

    public var body: some View {
        NavigationStack {
            VStack {
                List {
                    Group {
                        ForEach(Array(Subscreen.allCases)) { subscreen in
                            NavigationLink(subscreen.displayString, value: subscreen)
                        }

                        Button {
                            store.send(.resetAllSubjectsProgressButtonTapped)
                        } label: {
                            Label("Zacznij od nowa", systemImage: "exclamationmark.arrow.circlepath")
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                }
                        }
                        .padding()
                        .tint(.red)

                        Divider()

                        HStack {
                            Text("\(store.appVersion.title)")
                                .font(.caption)
                            Text("\(store.appVersion.value)")
                                .font(.caption.bold())
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.primaryBackground)
                }
                .scrollContentBackground(.hidden)
                .background(Color.primaryBackground)
            }
            .navigationDestination(for: Subscreen.self) { subscreen in
                switch subscreen {
                case .appearance:
                    Appearance(colorScheme: $store.userSettings.colorScheme)
                }
            }
            .alert(store: store.scope(state: \.$alert, action: \.alert))
        }
    }

    public init(store: StoreOf<Settings>) {
        self.store = store
    }
}

enum Subscreen: String, Identifiable, CaseIterable {
    case appearance

    var id: String { rawValue }

    var displayString: String {
        switch self {
        case .appearance:
            "Appearance"
        }
    }
}

#Preview {
    SettingsView(store: Store(initialState: Settings.State(), reducer: {
        Settings()
    }))
}
