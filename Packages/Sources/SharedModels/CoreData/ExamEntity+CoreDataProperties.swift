import CoreData
import Foundation

extension ExamEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExamEntity> {
        NSFetchRequest<ExamEntity>(entityName: "ExamEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var background: String?
    @NSManaged public var logo: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var subjects: NSSet?
}

// MARK: Generated accessors for subjects

extension ExamEntity {
    @objc(addSubjectsObject:)
    @NSManaged public func addToSubjects(_ value: SubjectEntity)

    @objc(removeSubjectsObject:)
    @NSManaged public func removeFromSubjects(_ value: SubjectEntity)

    @objc(addSubjects:)
    @NSManaged public func addToSubjects(_ values: NSSet)

    @objc(removeSubjects:)
    @NSManaged public func removeFromSubjects(_ values: NSSet)
}
