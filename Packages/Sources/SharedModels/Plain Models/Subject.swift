import Foundation

public struct Subject: Equatable, Hashable {
    public var id: String?
    public var title: String?
    public var image: String?
    public var questions: [Question]?

    public init(
        id: String? = "",
        title: String?,
        image: String?,
        questions: [Question] = []
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.questions = questions
    }
}

extension Subject {
    public init(
        dto: SubjectDto
    ) {
        id = dto.id
        title = dto.title
        image = dto.image
        questions = dto.questions?.enumerated().map { index, questionDto in
            Question(order: index, dto: questionDto)
        }
    }
}

extension Subject {
    public static let mock = Subject(title: "Zasady Lotu", image: "paperplane.fill", questions: [.mock, .mock2])
}
