import Foundation

public struct Subject: Equatable {
    public var id: String?
    public var title: String?
    public var image: String?
    public var currentProgress: Int?
    public var questions: [Question]?

    public var isLastQuestion: Bool {
        guard let questionsCount = questions?.count, let currentProgress else {
            return false
        }

        let lastIndex = questionsCount - 1
        return currentProgress <= lastIndex
    }

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
        questions = dto.questions.enumerated().map { index, questionDTO in
            Question(order: index, dto: questionDTO)
        }
    }
}

#if DEBUG
extension Subject {
    public static let mock = Subject(title: "Zasady Lotu", image: "paperplane.fill", questions: [.mock, .mock2])
}
#endif
