import AcknowList
import Roadmap
import SharedModels
import SharedViews
import SwiftUI

public struct SettingsView: View {
    @ObserveInjection private var iO

    @Bindable
    public var model: SettingsModel

    public init(model: SettingsModel) {
        self.model = model
    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(Array(SettingsModel.Subscreen.allCases)) { subscreen in
                    NavigationLink(subscreen.displayString, value: subscreen)
                }
            }
            .navigationDestination(for: SettingsModel.Subscreen.self) { subscreen in
                switch subscreen {
                case .licenses:
                    if let licenses = AcknowParser.defaultAcknowList() {
                        AcknowListSwiftUIView(acknowList: licenses)
                    }
                case .roadmap:
                    RoadmapView(configuration: RoadmapConfiguration(
                        roadmapJSONURL: URL(string: "https://simplejsoncms.com/api/83pe0psm7e")!,
                        voter: CustomFeatureVoter(),
                        namespace: "roadmaptest",
                        allowVotes: true,
                        allowSearching: true
                    ))
                case .betaSettings:
                    BetaSettingsView(
                        viewModel: .init(
                            settings: model.betaSettings,
                            externalData: .init(),
                            save: { newValue in
                                model.subscreen = nil
                                model.betaSettings = newValue
                            },
                            dismiss: { model.subscreen = nil }
                        )
                    )
                case .settings:
                    EmptyView()
                }
            }
        }
        .enableInjection()
    }
}
