import Foundation

public struct AnswerDto: Codable {
    public var id: String
    public let answerText: String
    public let isCorrect: Bool?
}
