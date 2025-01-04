import SwiftUI

public struct MainView: View {
    @Environment(SceneState.self) private var scene

    @State private var navigationSplitViewVisibility: NavigationSplitViewVisibility = .all

    public var body: some View {
        @Bindable var scene = scene
        NavigationSplitView(columnVisibility: $navigationSplitViewVisibility) {
            SidebarView()
                .toolbar(removing: .sidebarToggle)
                .navigationSplitViewColumnWidth(200)
        } detail: {
            NavigationStack(path: $scene.navigationStack) {
                Router.DestinationView(router: scene.mainSelection)
                    .navigationDestination(for: Router.self) { router in
                        Router.DestinationView(router: router)
                    }
            }
        }
        .onChange(of: scene.navigationStack) { _, item in
            scene.detailSelection = item.last ?? scene.mainSelection
        }
    }

    public init() {}
}

#Preview {
    MainView()
}
