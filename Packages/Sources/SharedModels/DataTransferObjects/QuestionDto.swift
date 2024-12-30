import Foundation

public struct QuestionDto: Codable {
    public let id: String
    public let questionNumber: String
    public let title: String
    public let answers: [AnswerDto]?
}
