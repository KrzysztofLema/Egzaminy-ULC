import Foundation

public struct Exam: Identifiable, Equatable {
    public var id = UUID()
    public var title: String
    public var subtitle: String
    public var text: String
    public var image: String
    public var background: String
    public var logo: String
    public var subjects: [Subject]
}

extension Exam {
    public init(dto: ExamDto) {
        title = dto.title
        subtitle = dto.subtitle
        text = dto.text
        image = dto.image
        background = dto.background
        logo = dto.logo
        subjects = dto.subjects.map(Subject.init)
    }
}
