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
    @State private var homeModel = HomeModel(postProvider: .init(loadPosts: {
        ([Post(title: "Title", subtitle: "Subtitle")], [])
    }), animationSettings: .init())

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
            HomeView(model: homeModel)
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
        .onChange(of: settingsModel.betaSettings.animations) { _, value in
            homeModel.animationSettings = value
        }
        .enableInjection()
    }
}
