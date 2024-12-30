import Dependencies
import Foundation
import SharedModels

public struct ExamAPIClient {
    public var fetchExams: @Sendable () async throws -> [Exam]
    public var fetchExam: @Sendable (String?) async throws -> Exam
}

extension ExamAPIClient: DependencyKey {
    public static var liveValue: ExamAPIClient {
        Self {
            let requestManager = RequestManager()
            do {
                let exams: [ExamDto] = try await requestManager.perform(ExamsRequest.getExams)
                return exams.map { Exam(dto: $0) }
            } catch {
                throw NetworkError.invalidServerResponse
            }
        } fetchExam: { identifier in
            let requestManager = RequestManager()
            do {
                let exam: ExamDto = try await requestManager.perform(ExamsRequest.getExamBy(identifier: identifier))
                return Exam(dto: exam)
            } catch {
                throw NetworkError.invalidServerResponse
            }
        }
    }
}

extension ExamAPIClient: TestDependencyKey {
    public static let testValue = Self {
        []
    } fetchExam: { _ in
        .mock1
    }
}

extension DependencyValues {
    public var examsApiClient: ExamAPIClient {
        get { self[ExamAPIClient.self] }
        set { self[ExamAPIClient.self] = newValue }
    }
}
