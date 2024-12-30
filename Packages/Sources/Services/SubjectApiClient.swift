import Dependencies
import Foundation
import SharedModels

public struct SubjectAPIClient {
    public var fetchSubjects: @Sendable (_ identifier: String) async throws -> [Subject]
}

extension SubjectAPIClient: DependencyKey {
    public static var liveValue: SubjectAPIClient {
        Self { identifier in
            let requestManager = RequestManager()

            do {
                let subjects: [SubjectDto] = try await requestManager.perform(SubjectsRequest.getSubjectBy(identifier: identifier))
                return subjects.map { Subject(dto: $0) }
            } catch {
                throw NetworkError.invalidServerResponse
            }
        }
    }
}

extension SubjectAPIClient: TestDependencyKey {
    public static let testValue = Self { _ in [] }
}

extension DependencyValues {
    public var subjectAPIClient: SubjectAPIClient {
        get { self[SubjectAPIClient.self] }
        set { self[SubjectAPIClient.self] = newValue }
    }
}
