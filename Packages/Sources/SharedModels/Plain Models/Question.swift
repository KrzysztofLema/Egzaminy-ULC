import Foundation

public struct Question: Identifiable, Equatable {
    public var id: String?
    public var order: Int?
    public var questionNumber: String?
    public var title: String?
    public var answers: [Answer]?

    public init(
        id: UUID = UUID(),
        order: Int?,
        questionNumber: String?,
        title: String?,
        answers: [Answer]?
    ) {
        self.id = id.uuidString
        self.order = order
        self.questionNumber = questionNumber
        self.title = title
        self.answers = answers
    }
}

extension Question {
    public init(
        id: UUID = UUID(),
        order: Int,
        dto: QuestionDto
    ) {
        self.id = id.uuidString
        self.order = order
        questionNumber = dto.questionNumber
        title = dto.title
        answers = dto.answers.map { Answer(dto: $0) }
    }
}

extension Question {
    public static let mock = Question(
        order: 0,
        questionNumber: "PL080-0001",
        title: "Czy profile klasyczne są dużo bardziej \"wrażliwe\" na zabrudzenia od profili laminarnych?",
        answers: Answer.mockAnswers
    )

    public static let mock2 = Question(
        order: 1,
        questionNumber: "PL080-0003",
        title: "Aby zapobiec zjawisku flateru giętno-lotkowemu należy:",
        answers: Answer.mockAnswers
    )
}
