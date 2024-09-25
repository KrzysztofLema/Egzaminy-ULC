import CoreData
import Foundation

extension Subject: CoreDataPersistable {
    init() {}

    var keyMap: [PartialKeyPath<Subject>: String] {
        [
            \.image: "image",
            \.title: "title",
            \.questions: "questions",
        ]
    }

    public func toManagedObject(context: NSManagedObjectContext) -> ManagedType {
        let persistedValue = SubjectEntity(context: context)
        persistedValue.id = id
        persistedValue.image = image
        persistedValue.title = title
        persistedValue.timestamp = Date()
        persistedValue.addToQuestions(NSSet(array: questions?.enumerated().map { index, question -> QuestionEntity in
            let mutableQuestion = question
            return mutableQuestion.toManagedObject(context: context, order: index)
        } ?? []))

        return persistedValue
    }

    public typealias ManagedType = SubjectEntity

    public init(managedObject: SubjectEntity?) {
        guard let managedObject else { return }
        id = managedObject.id
        image = managedObject.image
        title = managedObject.title

        let questions = managedObject.questions?.allObjects as? [QuestionEntity]

        self.questions = questions?.map { Question(managedObject: $0) } ?? []
    }
}
