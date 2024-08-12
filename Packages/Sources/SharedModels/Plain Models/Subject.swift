import Foundation

public struct Subject: Identifiable, Codable, Equatable {
    public let id = UUID()
    public let title: String
    public let image: String
    public let questions: [Question]
}
