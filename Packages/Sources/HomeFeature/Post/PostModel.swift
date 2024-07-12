import Foundation
import Observation
import SharedModels

@Observable
class PostModel: Identifiable {
    let post: Post
    var id: Post.ID { post.id }
    var isOpen: Bool

    init(post: Post, isOpen: Bool) {
        self.post = post
        self.isOpen = isOpen
    }
}
