import Foundation

public struct Post: Identifiable {
    public var id: UUID = .init()
    public var title: String
    public var subtitle: String
    public init(
        id: UUID = .init(),
        title: String,
        subtitle: String
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }
}
