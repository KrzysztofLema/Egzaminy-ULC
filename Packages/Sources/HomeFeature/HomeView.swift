import AutomaticSettings
import ComposableArchitecture
import ExamDetailFeature
import ExamsListFeature
import LifetimeTracker
import SettingsFeature
import SharedModels
import SharedViews
import SwiftUI

var stored: [LeakableModel] = []

public struct HomeView: View {
    @Bindable var store: StoreOf<Home>
    @ObserveInjection private var iO
    @Environment(\.colorScheme) var colorScheme

    public init(store: StoreOf<Home>) {
        self.store = store
    }

    public var body: some View {
        TabView(selection: $store.selectedTab.sending(\.onTabSelection)) {
            ExamsListView(store: store.scope(state: \.examsList, action: \.examsList))
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Home.Tab.exams)

            SettingsView(store: store.scope(state: \.settings, action: \.settings))
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Home.Tab.settings)
        }

        .enableInjection()
    }
}
