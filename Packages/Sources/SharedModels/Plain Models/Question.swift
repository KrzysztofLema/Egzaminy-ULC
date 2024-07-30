import Foundation

public struct Question: Identifiable, Codable {
    public let id = UUID()
    public let title: String
    public let anwsers: [Anwser]
    public let correctAnwser: String
}
