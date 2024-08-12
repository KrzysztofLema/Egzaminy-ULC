import AcknowList
import AutomaticSettings
import ComposableArchitecture
import ExamDetailFeature
import ExamsListFeature
import LifetimeTracker
import Roadmap
import SettingsFeature
import SharedModels
import SharedViews
import SwiftUI

var stored: [LeakableModel] = []

public struct HomeView: View {
    @Bindable var store: StoreOf<Home>
    @ObserveInjection private var iO
    @State private var settingsModel = SettingsModel()

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

            SettingsView(model: settingsModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Home.Tab.settings)
        }
        .enableInjection()
    }
}
