import Foundation

public struct Subject: Identifiable, Codable {
    public let id = UUID()
    public let title: String
    public let image: String
    public let questions: [Question]
}
