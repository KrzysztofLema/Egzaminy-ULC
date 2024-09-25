import Foundation

public struct Answer: Identifiable, Equatable, Hashable {
    public var id: String?
    public var answerID: String?
    public var answerTitle: String?
    public var isCorrect: Bool?

    public init(
        id: UUID? = UUID(),
        answerID: String?,
        answerTitle: String?,
        isCorrect: Bool?
    ) {
        self.id = id?.uuidString
        self.answerID = answerID
        self.answerTitle = answerTitle
        self.isCorrect = isCorrect
    }
}

extension Answer {
    public init(id: UUID = UUID(), dto: AnswerDto) {
        self.id = id.uuidString
        answerID = dto.answerID
        answerTitle = dto.answerText
        isCorrect = dto.isCorrect
    }
}

extension Answer {
    public static let mockAnswers: [Answer] = [
        Answer(answerID: "a", answerTitle: "Nie, ale tylko na małych kątach natarcia", isCorrect: false),
        Answer(answerID: "b", answerTitle: "Nie", isCorrect: true),
        Answer(answerID: "c", answerTitle: "Tak, ale tylko na dużych kątach natarcia", isCorrect: false),
        Answer(answerID: "d", answerTitle: "Tak", isCorrect: false),
    ]
}
