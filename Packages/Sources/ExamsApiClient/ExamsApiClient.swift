import Dependencies
import Foundation
import SharedModels

public struct ExamAPIClient {
    public var fetchExams: @Sendable () async throws -> [Exam]
}

extension ExamAPIClient: DependencyKey {
    public static var liveValue: ExamAPIClient {
        Self {
            let requestManager = RequestManager()
            let exams: [ExamDto] = try await requestManager.perform(ExamsRequest.getExams)

            return exams.map { Exam(dto: $0) }
        }
    }
}

extension ExamAPIClient: TestDependencyKey {
    public static let testValue = Self { [] }
}

extension DependencyValues {
    public var examsApiClient: ExamAPIClient {
        get { self[ExamAPIClient.self] }
        set { self[ExamAPIClient.self] = newValue }
    }
}
