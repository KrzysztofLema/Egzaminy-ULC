import SharedModels
import SwiftUI

struct ExamItem: View {
    let exam: Exam
    @State var isHovered = false
    @Binding var editingExam: Exam?

    var body: some View {
        NavigationLink(value: exam, label: {
            HStack {
                if let title = exam.title {
                    Text(title)
                }
                Spacer()
                if isHovered {
                    Button(action: {
                        editingExam = exam
                    }, label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(.white.opacity(0.5))
                    })
                    .buttonStyle(.plain)
                }
            }
        })
        .onHover(perform: { hovering in
            isHovered = hovering
        })
    }
}
