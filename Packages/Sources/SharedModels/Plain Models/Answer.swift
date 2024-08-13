import Foundation

public struct Answer: Identifiable, Codable, Equatable {
    public let id = UUID()
    public let answerID: String
    public let answerText: String
    public let isCorrect: Bool

    private enum CodingKeys: CodingKey {
        case answerID
        case answerText
        case isCorrect
    }

    public init(
        answerID: String,
        answerText: String,
        isCorrect: Bool
    ) {
        self.answerID = answerID
        self.answerText = answerText
        self.isCorrect = isCorrect
    }
}

extension Answer {
    public static var mock = Answer(answerID: "A", answerText: "Nie, ale tylko na małych kątach natarcia", isCorrect: false)
}
