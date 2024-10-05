import CoreData
import Dependencies
import Foundation
import SharedModels

public struct CoreDataClient: DependencyKey {
    public var fetchAllExams: @Sendable () throws -> [Exam]
    public var fetchExamByID: @Sendable (Exam.ID) throws -> Exam
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
    } fetchExamByID: { _ in
        .mock1
    } fetchQuestion: { _, _ in
        .mock
    } fetchAllAnswers: { _ in
        []
    } saveExams: {}
}
