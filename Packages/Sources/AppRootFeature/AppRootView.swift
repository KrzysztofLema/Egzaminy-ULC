import ComposableArchitecture
import ExamsListFeature
import HomeFeature
import OnboardingFeature
import SwiftUI

public struct AppRootView: View {
    @Bindable var store: StoreOf<AppRoot>

    public var body: some View {
        switch $store.userSettings.didFinishOnboarding.wrappedValue {
        case .onboarding:
            OnboardingFeatureView(store: store.scope(state: \.onboarding, action: \.onboarding))
                .zIndex(1)
        case .home:
            HomeView(store: store.scope(state: \.home, action: \.home))
        }
    }

    public init(store: StoreOf<AppRoot>) {
        self.store = store
    }
}
