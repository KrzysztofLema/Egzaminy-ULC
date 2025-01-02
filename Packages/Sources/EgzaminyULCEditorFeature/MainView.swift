import SwiftUI

public struct MainView: View {
    public var body: some View {
        NavigationSplitView(sidebar: {
            SidebarView()
        }, content: {
            TableView()
        }, detail: {
            Text("Detail")
        })
    }

    public init() {}
}

#Preview {
    MainView()
}
