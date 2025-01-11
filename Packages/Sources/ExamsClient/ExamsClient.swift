import Dependencies
import Foundation
import SharedModels

public struct ExamClient {
    public var exams: @Sendable () throws -> [Exam]
}

extension ExamClient: DependencyKey {
    public static var liveValue: ExamClient {
        // swiftlint:disable:next force_unwrapping
        let url = Bundle.main.url(forResource: "ExamsMock", withExtension: "json")!
        let exams: [ExamDto]

        do {
            let data = try Data(contentsOf: url)
            exams = try JSONDecoder().decode([ExamDto].self, from: data)
        } catch {
            // TODO: Error Handling
            exams = []
        }

        return Self(exams: {
            exams.map { Exam(dto: $0) }
        })
    }
}

extension ExamClient: TestDependencyKey {
    public static let testValue = Self { [] }
}

extension DependencyValues {
    public var examsClient: ExamClient {
        get { self[ExamClient.self] }
        set { self[ExamClient.self] = newValue }
    }
}

extension URL {
    static let exams = Bundle.main.url(forResource: "ExamsMock", withExtension: "json")
}
