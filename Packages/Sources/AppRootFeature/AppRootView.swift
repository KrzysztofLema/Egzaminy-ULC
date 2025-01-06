import ComposableArchitecture
import ExamsListFeature
import HomeFeature
import OnboardingFeature
import SwiftUI

public struct AppRootView: View {
    @Bindable var store: StoreOf<AppRoot>

    public var body: some View {
        ZStack {
            switch $store.userSettings.applicationState.wrappedValue {
            case .onboarding:
                OnboardingFeatureView(store: store.scope(state: \.onboarding, action: \.onboarding))
                    .transition(.move(edge: .leading))
            case .home:
                HomeView(store: store.scope(state: \.home, action: \.home))
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.smooth, value: store.userSettings.applicationState)
    }

    public init(store: StoreOf<AppRoot>) {
        self.store = store
    }
}
