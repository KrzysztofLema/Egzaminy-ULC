import CoreData
import Foundation

extension Answer: CoreDataPersistable {
    init() {}
    var keyMap: [PartialKeyPath<Answer>: String] {
        [
            \.id: "id",
            \.answerTitle: "answerTitle",
            \.isCorrect: "isCorrect",
        ]
    }

    func toManagedObject(context: NSManagedObjectContext) -> ManagedType {
        let persistedValue = AnswerEntity(context: context)
        persistedValue.id = id
        persistedValue.answerTitle = answerTitle
        persistedValue.isCorrect = isCorrect ?? false

        return persistedValue
    }

    typealias ManagedType = AnswerEntity

    public init(managedObject: AnswerEntity?) {
        guard let managedObject else { return }
        id = managedObject.id
        answerTitle = managedObject.answerTitle
        isCorrect = managedObject.isCorrect
    }
}
