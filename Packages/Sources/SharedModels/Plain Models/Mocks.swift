import Foundation

#if DEBUG
public struct ExamMock: Codable {
    let exams: [ExamDto]
}

private func loadExams() -> [Exam] {
    guard let url = Bundle.main.url(forResource: "ExamsMock", withExtension: "json"), let data = try? Data(contentsOf: url) else {
        return []
    }
    let decoder = JSONDecoder()

    var jsonMock: ExamMock?

    do {
        jsonMock = try decoder.decode(ExamMock.self, from: data)
    } catch {
        print(error)
    }

    return jsonMock?.exams.map(Exam.init) ?? []
}

extension Exam {
    public static let jsonMock = loadExams()
    public static let examMock = Self(
        title: "PPL(A)",
        subtitle: "Licencja Pilota Turystycznego Samolotowego PPL(A)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd lotnictwa cywilnego do licencji Turystycznej Samolotowej PPL(A).",
        image: "cessna-c172",
        background: "PPL(A)-Background",
        logo: "logo-1",
        subjects: [.mock]
    )
}

extension Subject {
    public static let mock = Subject(
        title: "Zasady Lotu",
        image: "paperplane.fill",
        questions: [.mock, .mock]
    )
}

extension Question {
    public static let mock = Self(
        questionNumber: "PL080-0001",
        title: "Czy profile klasyczne są dużo bardziej \"wrażliwe\" na zabrudzenia od profili laminarnych?",
        answers: [.mock1, .mock2, .mock3, .mock4]
    )
}

extension Answer {
    public static let mock1 = Self(answerID: "a", answerText: "Nie, ale tylko na małych kątach natarcia", isCorrect: false)
    public static let mock2 = Self(answerID: "a", answerText: "Nie, ale tylko na małych kątach natarcia", isCorrect: false)
    public static let mock3 = Self(answerID: "a", answerText: "Nie, ale tylko na małych kątach natarcia", isCorrect: false)
    public static let mock4 = Self(answerID: "a", answerText: "Nie, ale tylko na małych kątach natarcia", isCorrect: false)
}
#endif
