import ComposableArchitecture
import ExamsListFeature
import HomeFeature
import OnboardingFeature
import SwiftUI

public struct AppRootView: View {
    var store: StoreOf<AppRoot>

    public var body: some View {
        if store.userSettings.didFinishOnboarding {
            HomeView(store: store.scope(state: \.home, action: \.home))
        } else {
            if let store = store.scope(state: \.destination?.onboarding, action: \.destination.onboarding) {
                OnboardingFeatureView(store: store)
            }
        }
    }

    public init(store: StoreOf<AppRoot>) {
        self.store = store
    }
}
