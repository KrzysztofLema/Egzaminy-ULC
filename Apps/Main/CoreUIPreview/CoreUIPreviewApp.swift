import CoreUI
import SwiftUI

@main
struct CoreUIPreviewApp: App {
    var body: some Scene {
        WindowGroup {
            FullScreenErrorView {
                print("Dismiss")
            }
        }
    }
}
