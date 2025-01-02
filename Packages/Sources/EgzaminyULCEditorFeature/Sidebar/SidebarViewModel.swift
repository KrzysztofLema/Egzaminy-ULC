import Foundation
import Observation
import Services
import SharedModels

@Observable
internal final class SidebarViewModel {
    var exams: [Exam] = []
    var isLoading = false
    var isEditing = false
    var editedExam: Exam?
    let examsDataSource: ExamDataSource

    internal init(
        examsDataSource: ExamDataSource = ExamDataSource(),
        exams: [Exam] = []
    ) {
        self.examsDataSource = examsDataSource
        self.exams = exams

        fetchExams()
    }

    private func fetchExams() {
        isLoading = true
        defer { isLoading = false }

        Task {
            let fetchedExams: [Exam] = try await examsDataSource.fetchExams()
            exams = fetchedExams
        }
    }
}
