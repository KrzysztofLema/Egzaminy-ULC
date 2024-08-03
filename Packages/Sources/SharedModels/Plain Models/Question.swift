import Foundation

public struct Question: Identifiable, Codable {
    public let id = UUID()
    public let questionNumber: String
    public let title: String
    public let answers: [Answer]
}
