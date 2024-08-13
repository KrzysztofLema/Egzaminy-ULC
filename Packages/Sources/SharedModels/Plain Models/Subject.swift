import Foundation

public struct Subject: Identifiable, Codable, Equatable {
    public let id = UUID()
    public let title: String
    public let image: String
    public let questions: [Question]

    private enum CodingKeys: CodingKey {
        case title
        case image
        case questions
    }

    public init(
        title: String,
        image: String,
        questions: [Question]
    ) {
        self.title = title
        self.image = image
        self.questions = questions
    }
}
