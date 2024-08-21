import Foundation

public struct Subject: Identifiable, Equatable {
    public let id: UUID
    public let title: String
    public let image: String
    public var currentProgress: Int = 0
    public let questions: [Question]
}

extension Subject {
    public init(
        id: UUID = UUID(),
        dto: SubjectDto
    ) {
        self.id = id
        title = dto.title
        image = dto.image
        questions = dto.questions.map { Question(dto: $0) }
    }
}

#if DEBUG
extension Subject {
    public static let mock = Subject(id: Subject.ID(), title: "Zasady Lotu", image: "paperplane.fill", questions: [.mock, .mock2])
}
#endif
