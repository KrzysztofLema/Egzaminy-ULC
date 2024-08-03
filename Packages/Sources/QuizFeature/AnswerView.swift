import Inject
import SharedModels
import SwiftUI

struct AnswerView: View {
    @ObserveInjection private var iO
    
    let answer: Answer
    
    var body: some View {
        HStack {
            Text("\("A"): ".uppercased())
            Text(answer.answer)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            
        )
        .cornerRadius(10)
        .onTapGesture {
            
        }

        .enableInjection()
    }
}

