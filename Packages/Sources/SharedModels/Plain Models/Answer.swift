import Foundation

public struct Answer: Identifiable, Codable, Equatable {
    public let id = UUID()
    public let answerID: String
    public let answer: String
    public let isCorrect: Bool
}


