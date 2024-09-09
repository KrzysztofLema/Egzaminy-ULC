import CoreData
import Dependencies
import Foundation
import SharedModels

public struct CoreDataClient: DependencyKey {
    public var saveExams: @Sendable () throws -> Void
    public var fetchAllExams: @Sendable () throws -> [Exam]
    public var fetchAllSubjects: @Sendable () throws -> [Subject]
}

extension DependencyValues {
    public var coreData: CoreDataClient {
        get { self[CoreDataClient.self] }
        set { self[CoreDataClient.self] = newValue }
    }
}

extension CoreDataClient: TestDependencyKey {
    public static var testValue: CoreDataClient = Self {} fetchAllExams: {
        []
    } fetchAllSubjects: {
        []
    }
}
