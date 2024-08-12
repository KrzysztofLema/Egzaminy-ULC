import ComposableArchitecture
import ExamsListFeature
import HomeFeature
import SwiftUI

public struct AppRootView: View {
    @Bindable var store: StoreOf<AppRoot>

    public var body: some View {
        HomeView(store: store.scope(state: \.home, action: \.home))
    }

    public init(store: StoreOf<AppRoot>) {
        self.store = store
    }
}
