import Foundation

public struct Exam: Identifiable, Equatable {
    public var id: UUID
    public var title: String
    public var subtitle: String
    public var text: String
    public var image: String
    public var background: String
    public var logo: String
    public var subjects: [Subject]
}

extension Exam {
    public init(id: UUID = UUID(), dto: ExamDto) {
        self.id = id
        title = dto.title
        subtitle = dto.subtitle
        text = dto.text
        image = dto.image
        background = dto.background
        logo = dto.logo
        subjects = dto.subjects.map { Subject(dto: $0) }
    }
}

#if DEBUG
extension Exam {
    public static let mock1 = Exam(
        id: Exam.ID(),
        title: "PPL(H)",
        subtitle: "Licencja Pilota Helikoptera PPL(H)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd lotnictwa cywilnego do licencji Turystycznej Pilota Helikoptera PPL(H)",
        image: "helicopter",
        background: "PPL(A)-Background",
        logo: "logo-1",
        subjects: []
    )

    public static let mock2 = Exam(
        id: Exam.ID(),
        title: "PPL(H)",
        subtitle: "Licencja Pilota Helikoptera PPL(H)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd lotnictwa cywilnego do licencji Turystycznej Pilota Helikoptera PPL(H)",
        image: "helicopter",
        background: "PPL(A)-Background",
        logo: "logo-1",
        subjects: []
    )
}
#endif
