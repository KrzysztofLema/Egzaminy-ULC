import Foundation

public struct Answer: Identifiable, Equatable, Hashable {
    public var id: String?
    public var answerTitle: String?
    public var isCorrect: Bool?

    public init(
        id: UUID? = UUID(),
        answerTitle: String?,
        isCorrect: Bool?
    ) {
        self.id = id?.uuidString
        self.answerTitle = answerTitle
        self.isCorrect = isCorrect
    }
}

extension Answer {
    public init(id: UUID = UUID(), dto: AnswerDto) {
        self.id = id.uuidString
        answerTitle = dto.answerText
        isCorrect = dto.isCorrect
    }
}

extension Answer {
    public static let mockAnswers: [Answer] = [
        Answer(answerTitle: "Nie, ale tylko na małych kątach natarcia", isCorrect: false),
        Answer(answerTitle: "Nie", isCorrect: true),
        Answer(answerTitle: "Tak, ale tylko na dużych kątach natarcia", isCorrect: false),
        Answer(answerTitle: "Tak", isCorrect: false),
    ]
}
