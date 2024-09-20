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
        } fetchAllSubjects: {
            @Dependency(\.storageProvider.context) var context

            let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()

            do {
                let fetchedSubjects = try context().fetch(fetchRequest)
                let sortDescriptor = NSSortDescriptor(keyPath: \SubjectEntity.timestamp, ascending: true)

                fetchRequest.sortDescriptors = [sortDescriptor]

                return fetchedSubjects.map {
                    Subject(managedObject: $0)
                }

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
        } resetAllSubjectsCurrentProgress: {
            @Dependency(\.storageProvider) var storageProvider

            let subjectsRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()

            let fetchedSubjects = try storageProvider.context().fetch(subjectsRequest)

            fetchedSubjects.forEach {
                $0.currentProgress = 0
            }

            storageProvider.save()

        } resetSubjectCurrentProgress: { subjectId in
            @Dependency(\.storageProvider) var storageProvider

            let subjectRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()
            subjectRequest.predicate = NSPredicate(format: "id == %@", subjectId ?? "")

            let fetchedSubject = try storageProvider.context().fetch(subjectRequest)

            guard let fetchedSubject = fetchedSubject.first else {
                throw CoreDataError.subjectNotFound
            }

            fetchedSubject.currentProgress = 0

            storageProvider.save()

            return Subject(managedObject: fetchedSubject)

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

        } updateSubject: { subject in
            @Dependency(\.storageProvider) var storageProvider

            let fetchRequest: NSFetchRequest<SubjectEntity> = SubjectEntity.fetchRequest()
            let subjectPredicate = NSPredicate(format: "id == %@", subject.id ?? "")

            fetchRequest.predicate = subjectPredicate
            fetchRequest.fetchLimit = 1

            let fetchedSubject = try storageProvider.context().fetch(fetchRequest)

            guard let subjectEntity = fetchedSubject.first else {
                throw CoreDataError.questionNotFound
            }

            subjectEntity.currentProgress = Int64(subject.currentProgress ?? 0)

            storageProvider.save()
        }
    }
}
