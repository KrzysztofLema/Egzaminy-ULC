import AppFeature
import SharedViews
import SwiftUI

@main
struct EgzaminyULCApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.colorScheme, .dark)
        }
    }
}
