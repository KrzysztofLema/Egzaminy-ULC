import CoreData
import Dependencies
import ExamsClient
import Foundation
import SharedModels

extension CoreDataClient {
    public static var liveValue: CoreDataClient {
        Self {
            @Dependency(\.storageProvider) var storageProvider
            do {
                @Dependency(\.examsClient) var examsClient
                let exams = try examsClient.exams()

                for var exam in exams {
                    exam.toManagedObject(context: try storageProvider.context())
                }
                try storageProvider.save()
            } catch {}

        } fetchAllExams: {
            let fetchRequest: NSFetchRequest<ExamEntity> = ExamEntity.fetchRequest()
            @Dependency(\.storageProvider.context) var context
            do {
                let fetchedExams = try context().fetch(fetchRequest)

                let sortDescriptor = NSSortDescriptor(keyPath: \ExamEntity.timestamp, ascending: true)

                fetchRequest.sortDescriptors = [sortDescriptor]

                return fetchedExams.map { Exam(managedObject: $0) }
            } catch {}

            return []
        } fetchAllSubjects: {
            let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()
            @Dependency(\.storageProvider.context) var context

            do {
                let fetchedSubjects = try context().fetch(fetchRequest)
                let sortDescriptor = NSSortDescriptor(keyPath: \SubjectEntity.timestamp, ascending: true)

                fetchRequest.sortDescriptors = [sortDescriptor]

                return fetchedSubjects.map { Subject(managedObject: $0) }
            } catch {}

            return []
        } fetchQuestion: { questionId in
            @Dependency(\.storageProvider.context) var context

            let fetchRequest: NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "order == %i", questionId)

            do {
                let fetchedQuestion = try context().fetch(fetchRequest)
                if let question = fetchedQuestion.first {
                    return Question(managedObject: question)
                }
            } catch {}
            return nil

        } fetchAllAnswers: { questionId in
            @Dependency(\.storageProvider.context) var context

            do {
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

            } catch {}

            return []
        }
    }
}
