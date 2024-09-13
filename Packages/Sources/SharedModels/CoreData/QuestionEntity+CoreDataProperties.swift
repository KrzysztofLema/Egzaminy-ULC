import CoreData
import Foundation

extension QuestionEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var order: Int16
    @NSManaged public var questionNumber: String?
    @NSManaged public var title: String?
    @NSManaged public var answer: NSSet?
    @NSManaged public var subject: SubjectEntity?
}

// MARK: Generated accessors for answer

extension QuestionEntity {
    @objc(addAnswerObject:)
    @NSManaged public func addToAnswer(_ value: AnswerEntity)

    @objc(removeAnswerObject:)
    @NSManaged public func removeFromAnswer(_ value: AnswerEntity)

    @objc(addAnswer:)
    @NSManaged public func addToAnswer(_ values: NSSet)

    @objc(removeAnswer:)
    @NSManaged public func removeFromAnswer(_ values: NSSet)
}
