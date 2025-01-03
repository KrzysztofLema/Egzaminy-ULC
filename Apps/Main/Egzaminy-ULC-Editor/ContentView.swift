import EgzaminyULCEditorFeature
import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
            .frame(
                minWidth: 700,
                idealWidth: 1000,
                maxWidth: .infinity,
                minHeight: 400,
                idealHeight: 800,
                maxHeight: .infinity
            )
    }
}

#Preview {
    ContentView()
}
