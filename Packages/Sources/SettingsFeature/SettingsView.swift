import ComposableArchitecture
import CoreUI
import SharedModels
import SharedViews
import SwiftUI

public struct SettingsView: View {
    @ObserveInjection private var iO

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
                        Text("Version number: 0.1")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .bottom)
                    }
                    .listRowBackground(Color.primaryBackground)
                }
                .scrollContentBackground(.hidden)
                .background(Color.primaryBackground)
            }
            .navigationDestination(for: Subscreen.self) { subscreen in
                switch subscreen {
                case .settings:
                    EmptyView()
                case .appearance:
                    Appearance(colorScheme: $store.userSettings.colorScheme)
                }
            }
        }
        .enableInjection()
    }

    public init(store: StoreOf<Settings>) {
        self.store = store
    }
}

enum Subscreen: String, Identifiable, CaseIterable {
    case settings
    case appearance

    var id: String { rawValue }

    var displayString: String {
        switch self {
        case .settings:
            "Settings"
        case .appearance:
            "Appearance"
        }
    }
}
