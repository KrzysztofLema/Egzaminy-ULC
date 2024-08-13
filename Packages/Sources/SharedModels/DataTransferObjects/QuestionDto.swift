import Foundation

public struct QuestionDto: Codable {
    public let questionNumber: String
    public let title: String
    public let answers: [AnswerDto]

    enum CodingKeys: CodingKey {
        case questionNumber
        case title
        case answers
    }
}
