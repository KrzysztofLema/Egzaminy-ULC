import Dependencies
import DependenciesMacros
import UIKit

@DependencyClient
public struct UIApplicationClient {
    public var setUserInterfaceStyle: @Sendable (UIUserInterfaceStyle) async -> Void
}

extension UIApplicationClient: DependencyKey {
    public static let liveValue = Self(
        setUserInterfaceStyle: { userInterfaceStyle in
            await MainActor.run {
                guard
                    let scene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene })
                    as? UIWindowScene
                else { return }
                scene.keyWindow?.overrideUserInterfaceStyle = userInterfaceStyle
            }
        }
    )
}

extension DependencyValues {
    public var applicationClient: UIApplicationClient {
        get { self[UIApplicationClient.self] }
        set { self[UIApplicationClient.self] = newValue }
    }
}
