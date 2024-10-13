import ComposableArchitecture
import CoreUI
import Providers
import SharedModels
import SharedViews
import SwiftUI

@ViewAction(for: Settings.self)
public struct SettingsView: View {
    @Bindable public var store: StoreOf<Settings>

    public var body: some View {
        NavigationStack(
            path: $store.scope(
                state: \.path,
                action: \.path
            )
        ) {
            VStack {
                List {
                    Group {
                        ForEach(Array(Subscreen.allCases)) { subscreen in
                            Button(action: {
                                send(subscreen.action)
                            }, label: {
                                HStack {
                                    Image(systemName: subscreen.iconSystemName)
                                    Text(subscreen.displayString)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            })
                        }

                        Button {
                            send(.resetAllSubjectsProgressButtonTapped)
                        } label: {
                            Label("\(LocalizationProvider.Settings.startOver)", systemImage: "exclamationmark.arrow.circlepath")
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                }
                        }
                        .disabled(store.currentQuizState.currentProgress.isEmpty)
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
            .alert(store: store.scope(state: \.$alert, action: \.alert))
        } destination: { store in
            switch store.case {
            case let .appearance(store):
                Appearance(store: store)
            }
        }
    }

    public init(store: StoreOf<Settings>) {
        self.store = store
    }
}

enum Subscreen: String, Identifiable, CaseIterable {
    case appearance
    case chooseSubject

    var id: String { rawValue }

    var displayString: String {
        switch self {
        case .appearance:
            "\(LocalizationProvider.Settings.appearance)"
        case .chooseSubject:
            "\(LocalizationProvider.Settings.chooseSubjectAgain)"
        }
    }

    var action: Settings.Action.View {
        switch self {
        case .appearance:
            return .appearanceButtonTapped
        case .chooseSubject:
            return .chooseSubjectButtonTapped
        }
    }

    var iconSystemName: String {
        switch self {
        case .appearance:
            return "paintpalette"
        case .chooseSubject:
            return "arrow.2.circlepath.circle.fill"
        }
    }
}

#Preview {
    SettingsView(store: Store(initialState: Settings.State(), reducer: {
        Settings()
    }))
}
