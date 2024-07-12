@testable import HomeFeature
import TestExtensions
import XCTest

final class PostViewTests: XCTestCase {
    func test_postView_shows_backCard_when_open() {
        // Arrange
        let view = PostView(model: .init(post: .init(title: "Front", subtitle: "Back"), isOpen: true), animationSettings: .init())

        // Act & Assert
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
