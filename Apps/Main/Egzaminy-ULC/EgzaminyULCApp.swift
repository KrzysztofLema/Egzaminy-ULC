import AppRootFeature
import ComposableArchitecture
import ExamDetailFeature
import ExamsListFeature
import HomeFeature
import SharedModels
import SharedViews
import SwiftUI

@main
struct EgzaminyULCApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView(store: Store(initialState: AppRoot.State(), reducer: {
                AppRoot()
                    ._printChanges()
            }))
        }
    }
}
