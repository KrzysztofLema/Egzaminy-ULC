import Dependencies
import Foundation
import Services
import SharedModels

@Observable
class ExamDataSource {
    private var examApiClient: ExamAPIClient
    private var subjectAPIClient: SubjectAPIClient
    private var questionsAPIClient: QuestionsAPIClient

    init(
        examApiClient: ExamAPIClient,
        subjectAPIClient: SubjectAPIClient,
        questionsAPIClient: QuestionsAPIClient
    ) {
        self.examApiClient = examApiClient
        self.subjectAPIClient = subjectAPIClient
        self.questionsAPIClient = questionsAPIClient
    }

    func fetchExams() async throws -> [Exam] {
        try await examApiClient.fetchExams()
    }

    func fetchSubjects(of exam: Exam) async throws -> [Subject] {
        guard let id = exam.id else {
            return []
        }

        return try await subjectAPIClient.fetchSubjects(id)
    }

    func fetchQuestions(of subject: Subject) async throws -> [Question] {
        guard let id = subject.id else {
            return []
        }

        return try await questionsAPIClient.fetchQuestions(id)
    }
}
