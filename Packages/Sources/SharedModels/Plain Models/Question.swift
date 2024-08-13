import Foundation

public struct Question: Identifiable, Equatable {
    public let id = UUID()
    public let questionNumber: String
    public let title: String
    public let answers: [Answer]
}

extension Question {
    public init(
        dto: QuestionDto
    ) {
        questionNumber = dto.questionNumber
        title = dto.title
        answers = dto.answers.map(Answer.init)
    }
}
