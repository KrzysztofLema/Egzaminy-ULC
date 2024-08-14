import Foundation

public struct Subject: Identifiable, Equatable {
    public let id = UUID()
    public let title: String
    public let image: String
    public var currentProgress: Int = 0
    public let questions: [Question]
}

extension Subject {
    public init(
        dto: SubjectDto
    ) {
        title = dto.title
        image = dto.image
        questions = dto.questions.map(Question.init)
    }
}
