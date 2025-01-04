import SharedModels
import SwiftUI

struct QuestionSplitView: View {
    private var subject: Subject

    @Environment(ExamDataSource.self) private var examDataSource

    @State var selectedQuestionID: Question.ID?
    @State var questions: [Question] = []

    init(subject: Subject) {
        self.subject = subject
    }

    var body: some View {
        HStack {
            QuestionDetails(selectedQuestionID: $selectedQuestionID, questions: $questions)
            Divider()
            if let questionID = selectedQuestionID, let question = questions.first(where: { $0.id == questionID }) {
                QuestionDetailView(question: question)
            } else {
                Text("Select a question to see details")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .task {
            await fetchQuestions()
        }
    }

    private func fetchQuestions() async {
        do {
            questions = try await examDataSource.fetchQuestions(of: subject)
        } catch {}
    }
}
