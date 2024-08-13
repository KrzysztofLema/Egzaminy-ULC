import Foundation

public struct AnswerDto: Codable {
    public let answerID: String
    public let answerText: String
    public let isCorrect: Bool

    private enum CodingKeys: CodingKey {
        case answerID
        case answerText
        case isCorrect
    }
}
