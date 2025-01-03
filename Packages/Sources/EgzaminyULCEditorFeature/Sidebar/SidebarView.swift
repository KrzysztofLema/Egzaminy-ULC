import SwiftUI

struct SidebarView: View {
    @Bindable private var viewModel = SidebarViewModel()

    var body: some View {
        List(viewModel.exams) { exam in
            ExamItem(exam: exam, editingExam: $viewModel.editedExam)
        }
        .sheet(item: $viewModel.editedExam) { exam in
            EditExamView(
                viewModel: EditExamViewModel(
                    editExamForm: .init(
                        title: exam.title!,
                        subtitle: exam.subtitle!,
                        text: exam.text!,
                        image: exam.image!,
                        background: exam.background!,
                        logo: exam.logo!
                    )
                )
            )
        }
    }

    init() {}
}

#Preview {
    SidebarView()
}
