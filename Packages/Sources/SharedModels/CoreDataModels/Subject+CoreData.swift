import CoreData
import Foundation

extension Subject: CoreDataPersistable {
    init() {}

    var keyMap: [PartialKeyPath<Subject>: String] {
        [
            \.image: "image",
            \.title: "title",
            \.currentProgress: "currentProgress",
            \.questions: "questions",
        ]
    }

    func toManagedObject(context: NSManagedObjectContext) -> ManagedType {
        let persistedValue = SubjectEntity(context: context)
        persistedValue.id = id
        persistedValue.image = image
        persistedValue.title = title
        persistedValue.timestamp = Date()
        persistedValue.currentProgress = Int64(currentProgress ?? 0)
        persistedValue.addToQuestions(NSSet(array: questions?.map { question -> QuestionEntity in
            let mutableQuestion = question
            return mutableQuestion.toManagedObject(context: context)
        } ?? []))

        return persistedValue
    }

    typealias ManagedType = SubjectEntity

    public init(managedObject: SubjectEntity?) {
        guard let managedObject else { return }
        id = managedObject.id
        image = managedObject.image
        title = managedObject.title
        currentProgress = Int(managedObject.currentProgress)

        let questions = managedObject.questions?.allObjects as? [QuestionEntity]

        self.questions = questions?.map { Question(managedObject: $0) } ?? []
    }
}
