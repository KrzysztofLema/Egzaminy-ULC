import Foundation
import Observation
import SharedModels

public struct PostProvider {
    public init(loadPosts: @escaping () async -> (posts: [Post], openIDs: Set<Post.ID>)) {
        self.loadPosts = loadPosts
    }

    public var loadPosts: () async -> (posts: [Post], openIDs: Set<Post.ID>)
}

@Observable
public class HomeModel {
    let postProvider: PostProvider

    var posts: [PostModel] = []
    public var animationSettings: BetaSettings.Animations

    public init(postProvider: PostProvider, animationSettings: BetaSettings.Animations) {
        self.postProvider = postProvider
        self.animationSettings = animationSettings
    }

    func onAppear() async {
        let posts = await postProvider.loadPosts()
        self.posts = posts.posts.map {
            PostModel(post: $0, isOpen: posts.openIDs.contains($0.id))
        }
    }
}
