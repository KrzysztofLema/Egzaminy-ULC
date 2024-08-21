import Foundation

public struct Answer: Identifiable, Equatable {
    public let id: UUID
    public let answerID: String
    public let answerText: String
    public let isCorrect: Bool
}

extension Answer {
    public init(id: UUID = UUID(), dto: AnswerDto) {
        self.id = id
        answerID = dto.answerID
        answerText = dto.answerText
        isCorrect = dto.isCorrect
    }
}

#if DEBUG
extension Answer {
    static let mockAnswers: [Answer] = [
        Answer(id: Answer.ID(), answerID: "a", answerText: "Nie, ale tylko na małych kątach natarcia", isCorrect: false),
        Answer(id: Answer.ID(), answerID: "b", answerText: "Nie", isCorrect: true),
        Answer(id: Answer.ID(), answerID: "c", answerText: "Tak, ale tylko na dużych kątach natarcia", isCorrect: false),
        Answer(id: Answer.ID(), answerID: "d", answerText: "Tak", isCorrect: false),
    ]
}
#endif
