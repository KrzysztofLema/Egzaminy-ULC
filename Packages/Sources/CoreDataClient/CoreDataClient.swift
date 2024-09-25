import CoreData
import Dependencies
import Foundation
import SharedModels

public struct CoreDataClient: DependencyKey {
    public var fetchAllExams: @Sendable () throws -> [Exam]
    public var fetchAllSubjects: @Sendable () throws -> [Subject]
    public var fetchQuestion: @Sendable (_ subjectID: Subject.ID, _ index: Int) throws -> Question
    public var fetchAllAnswers: @Sendable (_ index: Int) throws -> [Answer]
    public var saveExams: @Sendable () -> Void
}

extension DependencyValues {
    public var coreData: CoreDataClient {
        get { self[CoreDataClient.self] }
        set { self[CoreDataClient.self] = newValue }
    }
}

extension CoreDataClient: TestDependencyKey {
    public static var testValue: CoreDataClient = Self {
        []
    } fetchAllSubjects: {
        []
    } fetchQuestion: { _, _ in
        .mock
    } fetchAllAnswers: { _ in
        []
    } saveExams: {}
}
