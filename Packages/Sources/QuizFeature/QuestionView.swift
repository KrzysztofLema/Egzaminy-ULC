import SharedModels
import SwiftUI

struct QuestionView: View {
    var question: Question
    
    var body: some View {
        Text(question.title)
            .font(.title3.width(.condensed))
            .multilineTextAlignment(.center)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding(30)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding(.bottom, 35)
            .layoutPriority(1)

        ForEach(question.answers) { answer in
            AnswerView(answer: answer)
        }
    }
}
