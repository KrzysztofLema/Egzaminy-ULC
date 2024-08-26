import AppRootFeature
import ComposableArchitecture
import ExamDetailFeature
import ExamsListFeature
import HomeFeature
import SharedModels
import SharedViews
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    let store = Store(initialState: AppRoot.State()) {
        AppRoot()
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        store.send(.appDelegate(.didFinishLaunching))
        return true
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
