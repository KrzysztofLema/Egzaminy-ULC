import Foundation

public struct ExamDto: Codable {
    public var id: String
    public var title: String
    public var subtitle: String
    public var text: String
    public var image: String
    public var background: String
    public var logo: String
    public var subjects: [SubjectDto]

    enum CodingKeys: CodingKey {
        case id
        case title
        case subtitle
        case text
        case image
        case background
        case logo
        case subjects
    }
}
