import Foundation
import HomeFeature
import Inject
@_exported import Playbook
@_exported import PlaybookUI
import SharedModels

public enum AppScenarios {
    public static func build() -> Playbook {
        let appPlaybook = Playbook()
        appPlaybook.addScenarios(of: "Home") {
            Scenario("Closed", layout: .fill) {
                HomeView(model: .init(postProvider: .init(loadPosts: {
                    let post = Post(title: "Post", subtitle: "Subtitle")
                    return ([post], [])
                }), animationSettings: .init()))
            }

            Scenario("Open", layout: .fill) {
                HomeView(model: .init(postProvider: .init(loadPosts: {
                    let post = Post(title: "Post", subtitle: "Subtitle")
                    return ([post], .init([post.id]))
                }), animationSettings: .init()))
            }
        }

        return appPlaybook
    }
}
