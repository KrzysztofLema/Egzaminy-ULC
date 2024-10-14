import ComposableArchitecture
import LifetimeTracker
import MainMenuFeature
import Providers
import SettingsFeature
import SharedModels
import SharedViews
import SwiftUI

public struct HomeView: View {
    @Bindable var store: StoreOf<Home>
    @ObserveInjection private var iO
    @Environment(\.colorScheme) var colorScheme

    public init(store: StoreOf<Home>) {
        self.store = store
    }

    public var body: some View {
        TabView(selection: $store.selectedTab.sending(\.onTabSelection)) {
            Group {
                MainMenuView(store: store.scope(state: \.mainMenu, action: \.mainMenu))
                    .tabItem {
                        Label("\(LocalizationProvider.Tab.homeTab)", systemImage: "house")
                    }
                    .tag(Home.Tab.exams)

                SettingsView(store: store.scope(state: \.settings, action: \.settings))
                    .tabItem {
                        Label("\(LocalizationProvider.Tab.settingsTab)", systemImage: "gear")
                    }
                    .tag(Home.Tab.settings)
            }
            .toolbarColorScheme(colorScheme, for: .tabBar)
        }
        .enableInjection()
    }
}
