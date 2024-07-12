import AutomaticSettings
import Inject
import SharedModels
import SwiftUI

struct BetaSettingsView: View, AutomaticSettingsViewDSL {
    private enum Subscreen: Swift.Identifiable {
        case review

        var id: String {
            switch self {
            case .review:
                return "review"
            }
        }
    }

    @ObserveInjection
    private var iO

    @ObservedObject
    var viewModel: AutomaticSettingsViewModel<BetaSettings, BetaSettingsExternalData>

    @State(initialValue: nil)
    private var subscreen: Subscreen?

    var body: some View {
        content
            .navigationBarTitle("Beta Settings")
            .navigationBarItems(
                trailing: Group {
                    if viewModel.applicableChanges.isEmpty {
                        EmptyView()
                    } else {
                        Button("Save") {
                            viewModel.saveChanges()
                        }
                    }
                }
            )
            .enableInjection()
    }
}

extension BetaSettingsView {
    var content: some View {
        List {
            animationsLink()
        }
        .listStyle(.sidebar)
    }
}
