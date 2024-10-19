import Foundation

public struct Subject: Equatable, Hashable {
    public var id: String?
    public var title: String?
    public var image: String?
    public var questions: [Question]?

    public init(
        id: UUID? = UUID(),
        title: String?,
        image: String?,
        questions: [Question] = []
    ) {
        self.id = id?.uuidString
        self.title = title
        self.image = image
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
        questions = dto.questions.enumerated().map { index, questionDTO in
            Question(order: index, dto: questionDTO)
        }
    }
}

extension Subject {
    public static let mock = Subject(title: "Zasady Lotu", image: "paperplane.fill", questions: [.mock, .mock2])
}
