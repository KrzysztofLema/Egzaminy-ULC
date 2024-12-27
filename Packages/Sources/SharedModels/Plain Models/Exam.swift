import Foundation

public struct Exam: Identifiable, Equatable {
    public var id: String?
    public var title: String?
    public var subtitle: String?
    public var text: String?
    public var image: String?
    public var background: String?
    public var logo: String?
    public var subjects: [Subject]

    public init(
        id: String?,
        title: String?,
        subtitle: String?,
        text: String?,
        image: String?,
        background: String?,
        logo: String?,
        subjects: [Subject]
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.text = text
        self.image = image
        self.background = background
        self.logo = logo
        self.subjects = subjects
    }
}

extension Exam {
    public init(dto: ExamDto) {
        id = dto.id
        title = dto.title
        subtitle = dto.subtitle
        text = dto.text
        image = dto.image
        background = dto.background
        logo = dto.logo
        subjects = dto.subjects?.compactMap { Subject(dto: $0) } ?? []
    }
}

extension Exam {
    public static let mock1 = Exam(
        id: "1",
        title: "PPL(H)",
        subtitle: "Licencja Pilota Helikoptera PPL(H)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd lotnictwa cywilnego do licencji Turystycznej Pilota Helikoptera PPL(H)",
        image: "helicopter",
        background: "PPL(A)-Background",
        logo: "logo-1",
        subjects: []
    )

    public static let mock2 = Exam(
        id: "2",
        title: "PPL(H)",
        subtitle: "Licencja Pilota Helikoptera PPL(H)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd lotnictwa cywilnego do licencji Turystycznej Pilota Helikoptera PPL(H)",
        image: "helicopter",
        background: "PPL(A)-Background",
        logo: "logo-1",
        subjects: []
    )
}
