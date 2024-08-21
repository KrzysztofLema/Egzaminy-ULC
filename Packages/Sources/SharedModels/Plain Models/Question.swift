import Foundation

public struct Question: Identifiable, Equatable {
    public let id: UUID
    public let questionNumber: String
    public let title: String
    public let answers: [Answer]
}

extension Question {
    public init(
        id: UUID = UUID(),
        dto: QuestionDto
    ) {
        self.id = id
        questionNumber = dto.questionNumber
        title = dto.title
        answers = dto.answers.map { Answer(dto: $0) }
    }
}

extension Question {
    public static let mock = Question(
        id: Question.ID(),
        questionNumber: "PL080-0001",
        title: "Czy profile klasyczne są dużo bardziej \"wrażliwe\" na zabrudzenia od profili laminarnych?",
        answers: Answer.mockAnswers
    )

    public static let mock2 = Question(
        id: Question.ID(),
        questionNumber: "PL080-0003",
        title: "Aby zapobiec zjawisku flateru giętno-lotkowemu należy:",
        answers: Answer.mockAnswers
    )
}
