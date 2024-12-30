import Foundation

public struct Answer: Identifiable, Equatable, Hashable {
    public var id: String?
    public var answerTitle: String?
    public var isCorrect: Bool?

    public init(
        id: String = "",
        answerTitle: String?,
        isCorrect: Bool?
    ) {
        self.id = id
        self.answerTitle = answerTitle
        self.isCorrect = isCorrect
    }
}

extension Answer {
    public init(dto: AnswerDto) {
        id = dto.id
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
