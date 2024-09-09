import CoreData
import Foundation

extension Answer: CoreDataPersistable {
    init() {}
    var keyMap: [PartialKeyPath<Answer>: String] {
        [
            \.answerTitle: "answerTitle",
             \.answerID: "answerID",
             \.isCorrect: "isCorrect",
        ]
    }
    
    func toManagedObject(context: NSManagedObjectContext) -> ManagedType {
        let persistedValue = AnswerEntity(context: context)
        persistedValue.id = id
        persistedValue.answerID = answerID
        persistedValue.answerTitle = answerTitle
        persistedValue.isCorrect = isCorrect ?? false
        
        return persistedValue
    }
    
    typealias ManagedType = AnswerEntity
    
    init(managedObject: AnswerEntity?) {
        guard let managedObject else { return }
        id = managedObject.id
        answerID = managedObject.answerID
        answerTitle = managedObject.answerTitle
        isCorrect = managedObject.isCorrect
    }
}
