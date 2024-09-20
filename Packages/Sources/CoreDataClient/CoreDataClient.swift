import CoreData
import Dependencies
import Foundation
import SharedModels

public struct CoreDataClient: DependencyKey {
    public var fetchAllExams: @Sendable () throws -> [Exam]
    public var fetchAllSubjects: @Sendable () throws -> [Subject]
    public var fetchQuestion: @Sendable (_ subjectID: Subject.ID, _ index: Int) throws -> Question
    public var fetchAllAnswers: @Sendable (_ index: Int) throws -> [Answer]
    public var resetAllSubjectsCurrentProgress: @Sendable () throws -> Void
    public var resetSubjectCurrentProgress: @Sendable (_ subjectID: Subject.ID) throws -> Subject
    public var saveExams: @Sendable () -> Void
    public var updateSubject: @Sendable (Subject) throws -> Void
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
    } resetAllSubjectsCurrentProgress: {}
        resetSubjectCurrentProgress: { _ in
            .mock
        } saveExams: {} updateSubject: { _ in
        }
}
