import CoreData
import Foundation

extension SubjectEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubjectEntity> {
        NSFetchRequest<SubjectEntity>(entityName: "SubjectEntity")
    }

    @NSManaged public var currentProgress: Int64
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var exam: ExamEntity?
    @NSManaged public var questions: NSSet?
}

// MARK: Generated accessors for questions

extension SubjectEntity {
    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: QuestionEntity)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: QuestionEntity)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)
}
