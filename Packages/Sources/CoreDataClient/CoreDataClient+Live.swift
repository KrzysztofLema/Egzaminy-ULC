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

            do {
                let fetchedExams = try context().fetch(fetchRequest)
                let sortDescriptor = NSSortDescriptor(keyPath: \ExamEntity.timestamp, ascending: true)

                fetchRequest.sortDescriptors = [sortDescriptor]

                return fetchedExams.map { Exam(managedObject: $0) }
            } catch let error as NSError {
                throw CoreDataError.fetchError(error)
            }
        } fetchExamByID: { examId in
            @Dependency(\.storageProvider.context) var context
            let fetchRequest: NSFetchRequest<ExamEntity> = ExamEntity.fetchRequest()

            fetchRequest.predicate = NSPredicate(format: "id == %@", examId ?? "")
            fetchRequest.fetchLimit = 1

            do {
                let fetchedExam = try context().fetch(fetchRequest)

                guard let fetchedExam = fetchedExam.first else {
                    throw CoreDataError.questionNotFound
                }

                return Exam(managedObject: fetchedExam)

            } catch let error as NSError {
                throw CoreDataError.fetchError(error)
            }
        } fetchQuestion: { subjectId, questionOrder in
            @Dependency(\.storageProvider.context) var context

            let fetchRequest: NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "order == %i AND subject.id == %@", questionOrder, subjectId ?? "")

            do {
                let fetchedQuestion = try context().fetch(fetchRequest)

                guard let question = fetchedQuestion.first else {
                    throw CoreDataError.questionNotFound
                }

                return Question(managedObject: question)
            } catch let error as NSError {
                throw CoreDataError.fetchError(error)
            }
        } fetchAllAnswers: { questionId in
            @Dependency(\.storageProvider.context) var context

            let questionRequest: NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
            questionRequest.predicate = NSPredicate(format: "order == %i", questionId)
            questionRequest.fetchLimit = 1

            do {
                let fetchedQuestions = try context().fetch(questionRequest)

                guard let fetchedQuestion = fetchedQuestions.first else {
                    throw CoreDataError.questionNotFound
                }

                let answersRequest: NSFetchRequest<AnswerEntity> = AnswerEntity.fetchRequest()
                let answerPredicate = NSPredicate(format: "question == %@", fetchedQuestion)
                answersRequest.predicate = answerPredicate

                let fetchedAnswers = try context().fetch(answersRequest)

                return fetchedAnswers.map {
                    Answer(managedObject: $0)
                }

            } catch let error as NSError {
                throw CoreDataError.fetchError(error)
            }
        } saveExams: {
            @Dependency(\.storageProvider) var storageProvider
            @Dependency(\.examsClient) var examsClient

            do {
                let exams = try examsClient.exams()

                for var exam in exams {
                    exam.toManagedObject(context: try storageProvider.context())
                }

            } catch {}

            storageProvider.save()
        }
    }
}
