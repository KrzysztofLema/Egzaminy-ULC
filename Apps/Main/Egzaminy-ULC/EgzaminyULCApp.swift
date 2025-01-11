import AppRootFeature
import ComposableArchitecture
import ExamDetailFeature
import ExamsListFeature
import Helpers
import HomeFeature
import LaunchDarkly
import SharedModels
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    let store = Store(initialState: AppRoot.State()) {
        AppRoot()
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        configureLaunchDarkly()

        store.send(.appDelegate(.didFinishLaunching))
        return true
    }

    private func configureLaunchDarkly() {
        let launchDarklyMobKey = PlistConfiguration.App.launchDarklyMobKey
        let launchDarklyContextKey = PlistConfiguration.App.launchDarklyContextKey

        var config = LDConfig(mobileKey: launchDarklyMobKey, autoEnvAttributes: .enabled)
        config.logger = .disabled

        let contextBuilder = LDContextBuilder(key: launchDarklyContextKey)

        guard case .success = contextBuilder.build() else { return }
        LDClient.start(config: config, startWaitSeconds: 10)
    }
}

@main
struct EgzaminyULCApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            AppRootView(store: appDelegate.store)
        }
    }
}
