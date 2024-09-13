import CoreData
import Foundation

extension Question: CoreDataPersistable {
    init() {}

    var keyMap: [PartialKeyPath<Question>: String] {
        [
            \.id: "id",
            \.questionNumber: "questionNumber",
            \.title: "title",
            \.order: "order",
            \.answers: "answers",
        ]
    }

    public init(managedObject: QuestionEntity?) {
        guard let managedObject else { return }

        id = managedObject.id
        order = Int(managedObject.order)
        questionNumber = managedObject.questionNumber
        title = managedObject.title

        let answers = managedObject.answer?.allObjects as? [AnswerEntity]
        self.answers = answers?.map { Answer(managedObject: $0) } ?? []
    }

    public func toManagedObject(context: NSManagedObjectContext, order: Int) -> QuestionEntity {
        let persistedValue = QuestionEntity(context: context)
        persistedValue.id = id
        persistedValue.order = Int16(order)
        persistedValue.questionNumber = questionNumber
        persistedValue.title = title

        persistedValue.addToAnswer(NSSet(array: answers?.map { answer -> AnswerEntity in
            let mutableAnswer = answer
            return mutableAnswer.toManagedObject(context: context)
        } ?? []))

        return persistedValue
    }

    typealias ManagedType = QuestionEntity
}
