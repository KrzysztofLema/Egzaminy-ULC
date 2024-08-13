import Foundation

public struct Exam: Identifiable, Codable, Equatable {
    public var id = UUID()
    public var title: String
    public var subtitle: String
    public var text: String
    public var image: String
    public var background: String
    public var logo: String
    public var subjects: [Subject]

    enum CodingKeys: CodingKey {
        case title
        case subtitle
        case text
        case image
        case background
        case logo
        case subjects
    }

    init(
        title: String,
        subtitle: String,
        text: String,
        image: String,
        background: String,
        logo: String,
        subjects: [Subject]
    ) {
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
    static let mock = Exam(
        title: "PPL(A)",
        subtitle: "Licencja Pilota Turystycznego Samolotowego PPL(A)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd lotnictwa cywilnego do licencji Turystycznej Samolotowej PPL(A).",
        image: "cessna-c172",
        background: "PPL(A)-Background",
        logo: "logo-1",
        subjects: []
    )
}
