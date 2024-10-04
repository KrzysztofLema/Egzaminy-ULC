import ComposableArchitecture
import OnboardingFeature
import SwiftUI

@main
struct OnboardingFeaturePreviewApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingFeatureView(store: Store(initialState: Onboarding.State(onboardingSteps: .welcome), reducer: {
                Onboarding()
            }))
        }
    }
}