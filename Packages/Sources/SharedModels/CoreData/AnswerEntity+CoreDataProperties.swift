import CoreData
import Foundation

extension AnswerEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerEntity> {
        NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
    }

    @NSManaged public var answerTitle: String?
    @NSManaged public var id: String?
    @NSManaged public var isCorrect: Bool
    @NSManaged public var question: QuestionEntity?
}
