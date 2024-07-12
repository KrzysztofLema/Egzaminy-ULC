import Inject
import PlaybookFeature
import PlaybookUI
import SwiftUI

@main
struct PlaybookDemoApp: App {
    @ObserveInjection private var iO

    var body: some Scene {
        WindowGroup {
            PlaybookCatalog(
                playbook: AppScenarios.build()
            )
            .id(UUID())
            .enableInjection()
        }
    }
}
