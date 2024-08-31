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
                        HStack {
                            Text("\(store.appVersion.title)")
                                .font(.caption)
                            Text("\(store.appVersion.value)")
                                .font(.caption.bold())
                        }
                        .frame(maxWidth: .infinity, alignment: .bottom)
                    }
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
        }
        .enableInjection()
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
