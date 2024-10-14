import CoreData
import Foundation

extension Exam {
    public init(managedObject: ExamEntity) {
        id = managedObject.id
        title = managedObject.title
        subtitle = managedObject.subtitle
        text = managedObject.text
        image = managedObject.image
        background = managedObject.background
        logo = managedObject.logo

        let subjects = (managedObject.subjects?.allObjects as? [SubjectEntity])?.sorted {
            ($0.title ?? "") < ($1.title ?? "")
        }
        self.subjects = subjects?.map { Subject(managedObject: $0) } ?? []
    }

    private func checkForExistingExam(id: String, context: NSManagedObjectContext) -> Bool {
        let fetchRequest = ExamEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        if let results = try? context.fetch(fetchRequest), results.first != nil {
            return true
        }
        return false
    }

    public mutating func toManagedObject(context: NSManagedObjectContext) {
        guard let id else { return }
        guard checkForExistingExam(id: id, context: context) == false else { return }
        let persistedValue = ExamEntity(context: context)
        persistedValue.id = self.id
        persistedValue.title = title
        persistedValue.subtitle = subtitle
        persistedValue.image = image
        persistedValue.text = text
        persistedValue.timestamp = Date()
        persistedValue.background = background
        persistedValue.logo = logo

        persistedValue.addToSubjects(NSSet(array: subjects.map { subject -> SubjectEntity in
            let mutableSubject = subject
            return mutableSubject.toManagedObject(context: context)
        }))
    }
}
