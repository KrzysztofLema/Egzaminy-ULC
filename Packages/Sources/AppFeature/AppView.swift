import AcknowList
import AutomaticSettings
import HomeFeature
import LifetimeTracker
import Roadmap
import SettingsFeature
import SharedModels
import SharedViews
import SwiftUI

var stored: [LeakableModel] = []

public struct AppView: View {
    @ObserveInjection private var iO
    @State private var settingsModel = SettingsModel()

    public init() {
        #if DEBUG
        LifetimeTracker.setup(
            onUpdate: LifetimeTrackerDashboardIntegration(
                visibility: .visibleWithIssuesDetected,
                style: .circular
            ).refreshUI
        )
        #endif
    }

    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            VStack {
                Button("Leaks") {
                    stored.append(.init())
                }
            }
            .tabItem {
                Label("Leaks", systemImage: "memorychip")
            }

            SettingsView(model: settingsModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .enableInjection()
    }
}
