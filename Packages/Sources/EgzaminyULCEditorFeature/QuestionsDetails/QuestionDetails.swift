import SharedModels
import SwiftUI

struct QuestionDetails: View {
    @Binding var selectedQuestionID: Question.ID?
    @Binding var questions: [Question]

    var body: some View {
        Table(of: Question.self, selection: $selectedQuestionID) {
            TableColumn("id") { question in
                if let id = question.id {
                    Text("\(id)")
                }
            }
            TableColumn("question number") { question in
                if let number = question.questionNumber {
                    Text(number)
                }
            }
            TableColumn("title") { question in
                if let title = question.title {
                    Text("\(title)")
                }
            }
        } rows: {
            ForEach(questions) { question in
                TableRow(question)
            }
        }
        .onChange(of: selectedQuestionID) { _, _ in
        }
    }
}
