import Dependencies
import Foundation
import Services
import SharedModels

internal class ExamDataSource {
    @Dependency(\.examsApiClient) internal var examApiClient

    internal func fetchExams() async throws -> [Exam] {
        try await examApiClient.fetchExams()
    }
}
