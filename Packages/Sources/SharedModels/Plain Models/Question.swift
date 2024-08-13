import Foundation

public struct Question: Identifiable, Codable, Equatable {
    public let id = UUID()
    public let questionNumber: String
    public let title: String
    public let answers: [Answer]

    enum CodingKeys: CodingKey {
        case questionNumber
        case title
        case answers
    }

    public init(
        questionNumber: String,
        title: String,
        answers: [Answer]
    ) {
        self.questionNumber = questionNumber
        self.title = title
        self.answers = answers
    }
}

extension Question {
    public static var mock = Question(
        questionNumber: "PL080-0001",
        title: "Czy profile klasyczne są dużo bardziej \"wrażliwe\" na zabrudzenia od profili laminarnych?",
        answers: [
            .init(answerID: "a", answerText: "Nie, ale tylko na małych kątach natarcia", isCorrect: false),
            .init(answerID: "b", answerText: "Nie", isCorrect: true),
            .init(answerID: "c", answerText: "Tak, ale tylko na dużych kątach natarcia", isCorrect: false),
            .init(answerID: "d", answerText: "Tak", isCorrect: false),
        ]
    )
}
