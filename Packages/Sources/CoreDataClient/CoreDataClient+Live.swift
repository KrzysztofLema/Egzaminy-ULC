import CoreData
import Dependencies
import ExamsClient
import Foundation
import SharedModels

extension CoreDataClient {
    public static var liveValue: CoreDataClient {
        Self {
            @Dependency(\.storageProvider) var storageProvider
            do {
                @Dependency(\.examsClient) var examsClient
                let exams = try examsClient.exams()

                for var exam in exams {
                    exam.toManagedObject(context: try storageProvider.context())
                }
                try storageProvider.save()
            } catch {
                
            }

        } fetchAllExams: {
            let fetchRequest: NSFetchRequest<ExamEntity> = ExamEntity.fetchRequest()
            @Dependency(\.storageProvider.context) var context
            do {
                let fetchedExams = try context().fetch(fetchRequest)

                let sortDescriptor = NSSortDescriptor(keyPath: \ExamEntity.timestamp, ascending: true)

                fetchRequest.sortDescriptors = [sortDescriptor]

                return fetchedExams.map { Exam(managedObject: $0) }
            } catch {
                
            }

            return []
        } fetchAllSubjects: {
            let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()
            @Dependency(\.storageProvider.context) var context

            do {
                let fetchedSubjects = try context().fetch(fetchRequest)
                let sortDescriptor = NSSortDescriptor(keyPath: \SubjectEntity.timestamp, ascending: true)

                fetchRequest.sortDescriptors = [sortDescriptor]

                return fetchedSubjects.map { Subject(managedObject: $0) }
            } catch {
                
            }

            return []
        }
    }
}
