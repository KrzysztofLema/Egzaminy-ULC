import SharedModels
import SwiftUI

struct SidebarView: View {
    @Environment(ExamDataSource.self) private var examsDataSource
    @Environment(SceneState.self) private var scene

    @State var exams: [Exam] = []
    @State var isLoading = true
    @State var isEditing = false
    @State var selectedExam: Exam?
    @State var editedExam: Exam?

    var body: some View {
        @Bindable var scene = scene
        Group {
            switch (isLoading, exams) {
            case (true, _):
                ProgressView()
                    .frame(
                        width: 40,
                        height: 40
                    )
            case let (false, exams):
                List(
                    exams,
                    selection: $selectedExam
                ) { exam in
                    ExamItem(exam: exam, editingExam: $editedExam)
                }
            }
        }
        .listStyle(.sidebar)
        .sheet(item: $editedExam) { exam in
            EditExamView(editExamForm: .init(exam: exam))
        }
        .onChange(of: selectedExam) { _, newValue in
            guard let exam = newValue else {
                return
            }

            scene.mainSelection = .subjects(exam)
        }
        .task {
            await fetchExams()
        }
    }

    private func fetchExams() async {
        do {
            exams = try await examsDataSource.fetchExams()
            isLoading = false
        } catch {
            
        }
    }
}

#Preview {
    SidebarView()
}
