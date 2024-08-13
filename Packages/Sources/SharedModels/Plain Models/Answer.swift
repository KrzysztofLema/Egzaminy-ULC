import Foundation

public struct Answer: Identifiable, Equatable {
    public let id = UUID()
    public let answerID: String
    public let answerText: String
    public let isCorrect: Bool
}

extension Answer {
    public init(dto: AnswerDto) {
        answerID = dto.answerID
        answerText = dto.answerText
        isCorrect = dto.isCorrect
    }
}
