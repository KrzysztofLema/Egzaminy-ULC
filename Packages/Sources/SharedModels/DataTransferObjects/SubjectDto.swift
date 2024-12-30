import Foundation

public struct SubjectDto: Codable {
    public var id: String
    public let title: String
    public let image: String
    public let questions: [QuestionDto]?
}
