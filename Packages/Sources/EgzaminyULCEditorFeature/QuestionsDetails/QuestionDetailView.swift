import SharedModels
import SwiftUI

struct QuestionDetailView: View {
    let question: Question

    @Environment(ExamDataSource.self) private var examDataSource

    @State var questions: [Question] = []
    @State var selectedQuestionID: Question.ID?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Question Details")
                .font(.title)
                .bold()

            Text("ID: \(question.id ?? "N/A")")
            Text("Question Number: \(question.questionNumber ?? "N/A")")
            Text("Title: \(question.title ?? "N/A")")

            VStack {
                anwsers
            }
        }
        .padding()
    }

    private var anwsers: some View {
        VStack(alignment: .leading) {
            ForEach(question.answers ?? []) { answer in
                anwserView(anwser: answer)
            }
        }
    }

    private func anwserView(anwser: Answer) -> some View {
        HStack {
            Toggle(isOn: .init(get: {
                anwser.isCorrect ?? false
            }, set: { _ in

            })) {
                Text(anwser.answerTitle ?? "")
            }
            .toggleStyle(.checkbox)
        }
    }
}
