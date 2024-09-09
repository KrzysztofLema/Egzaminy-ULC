import Foundation

public struct Subject: Equatable {
    public var id: String?
    public var title: String?
    public var image: String?
    public var currentProgress: Int?
    public var questions: [Question]?

    public init(
        id: UUID? = UUID(),
        title: String?,
        image: String?,
        currentProgress: Int? = 0,
        questions: [Question] = []
    ) {
        self.id = id?.uuidString
        self.title = title
        self.image = image
        self.currentProgress = currentProgress
        self.questions = questions
    }
}

extension Subject {
    public init(
        id: UUID = UUID(),
        dto: SubjectDto
    ) {
        self.id = id.uuidString
        title = dto.title
        image = dto.image
        questions = dto.questions.map { Question(dto: $0) }
    }
}

#if DEBUG
extension Subject {
    public static let mock = Subject(title: "Zasady Lotu", image: "paperplane.fill", questions: [.mock, .mock2])
}
#endif
