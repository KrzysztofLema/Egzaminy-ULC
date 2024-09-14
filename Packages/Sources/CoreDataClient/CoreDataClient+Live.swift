import CoreData
import Dependencies
import ExamsClient
import Foundation
import SharedModels

extension CoreDataClient {
    public static var liveValue: CoreDataClient {
        Self {
            @Dependency(\.storageProvider.context) var context
            
            let fetchRequest: NSFetchRequest<ExamEntity> = ExamEntity.fetchRequest()
            let fetchedExams = try context().fetch(fetchRequest)
            let sortDescriptor = NSSortDescriptor(keyPath: \ExamEntity.timestamp, ascending: true)

            fetchRequest.sortDescriptors = [sortDescriptor]

            return fetchedExams.map { Exam(managedObject: $0) }
          
        } fetchAllSubjects: {
            @Dependency(\.storageProvider.context) var context
            
            let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()
            let fetchedSubjects = try context().fetch(fetchRequest)
            let sortDescriptor = NSSortDescriptor(keyPath: \SubjectEntity.timestamp, ascending: true)

            fetchRequest.sortDescriptors = [sortDescriptor]

            return fetchedSubjects.map { Subject(managedObject: $0) }
        } fetchQuestion: { questionId in
            @Dependency(\.storageProvider.context) var context

            let fetchRequest: NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "order == %i", questionId)

            let fetchedQuestion = try context().fetch(fetchRequest)
            
            if let question = fetchedQuestion.first {
                return Question(managedObject: question)
            }
            
            return nil

        } fetchAllAnswers: { questionId in
            @Dependency(\.storageProvider.context) var context

            let questionRequest: NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
            questionRequest.predicate = NSPredicate(format: "order == %i", questionId)
            questionRequest.fetchLimit = 1

            let fetchedQuestions = try context().fetch(questionRequest)

            guard let fetchedQuestion = fetchedQuestions.first else {
                    return []
            }

            let answersRequest: NSFetchRequest<AnswerEntity> = AnswerEntity.fetchRequest()
            let answerPredicate = NSPredicate(format: "question == %@", fetchedQuestion)
            answersRequest.predicate = answerPredicate

            let fetchedAnswers = try context().fetch(answersRequest)

            return fetchedAnswers.map { Answer(managedObject: $0) }

        } saveExams: {
            @Dependency(\.storageProvider) var storageProvider
            @Dependency(\.examsClient) var examsClient
            
            let exams = try examsClient.exams()

            for var exam in exams {
                exam.toManagedObject(context: try storageProvider.context())
            }
            
            try storageProvider.save()

        } updateSubject: { subject in
            @Dependency(\.storageProvider) var storageProvider
            
            let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()
            let subjectPredicate = NSPredicate(format: "id == %@", subject.id ?? "")

            fetchRequest.predicate = subjectPredicate
            fetchRequest.fetchLimit = 1

            let fetchedSubject = try storageProvider.context().fetch(fetchRequest)

            if let subjectEntity = fetchedSubject.first {
                subjectEntity.currentProgress = Int64(subject.currentProgress ?? 0)
            }
            
            try storageProvider.save()
        }
    }
}
