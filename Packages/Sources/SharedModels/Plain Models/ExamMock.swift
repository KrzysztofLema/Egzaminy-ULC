import Foundation

public struct ExamMock: Codable {
    let exams: [Exam]
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

    return jsonMock?.exams ?? []
}

extension ExamMock {
    public static let mock = loadExams()
}
