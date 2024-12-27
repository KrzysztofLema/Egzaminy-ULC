import Foundation

public struct AnswerDto: Codable {
    public let answerText: String
    public let isCorrect: Bool?

    private enum CodingKeys: CodingKey {
        case answerText
        case isCorrect
    }
}
