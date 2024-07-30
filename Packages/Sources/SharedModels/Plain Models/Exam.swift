import Foundation

public struct Exam: Identifiable, Codable {
    public let id = UUID()
    public var title: String
    public var subtitle: String
    public var text: String
    public var image: String
    public var background: String
    public var logo: String
    public var subjects: [Subject]
}
