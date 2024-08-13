import Foundation

public struct SubjectDto: Codable {
    public let title: String
    public let image: String
    public let questions: [QuestionDto]

    private enum CodingKeys: CodingKey {
        case title
        case image
        case questions
    }
}
