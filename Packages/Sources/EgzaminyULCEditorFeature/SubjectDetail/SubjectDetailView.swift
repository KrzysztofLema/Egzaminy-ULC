import SharedModels
import SwiftUI

struct SubjectDetailView: View {
    @Environment(SceneState.self) private var scene
    @Environment(ExamDataSource.self) private var examDataSource

    @State var subjects: [Subject] = []
    @State var selectedSubjectID: Subject.ID?
    @State var isLoading: Bool = true
    @State var errorOccured: Bool = false

    var exam: Exam

    init(exam: Exam) {
        self.exam = exam
    }

    var body: some View {
        VStack {
            if isLoading {
                progressView
            } else {
                tableContent
            }
        }
        .task {
            await fetchSubjects()
        }
        .onChange(of: selectedSubjectID) { _, selection in
            if let selection, let subject = subjects.first(where: { $0.id == selection }) {
                scene.navigationStack.append(.questionDetail(subject))
            }
        }
    }

    private var progressView: some View {
        ProgressView()
            .frame(
                width: 40,
                height: 40
            )
    }

    private var tableContent: some View {
        Table(of: Subject.self, selection: $selectedSubjectID) {
            TableColumn("id") { subject in
                if let id = subject.id {
                    Text(id)
                }
            }
            TableColumn("title") { subject in
                if let title = subject.title {
                    Text(title)
                }
            }
            TableColumn("image") { subject in
                if let image = subject.image {
                    Text(image)
                }
            }
        } rows: {
            ForEach(subjects) { subject in
                TableRow(subject)
                    .contextMenu {
                        Button {} label: {
                            Text("Edit")
                        }

                        Button {} label: {
                            Text("See details")
                        }
                    }
            }
        }
    }

    private func fetchSubjects() async {
        do {
            subjects = try await examDataSource.fetchSubjects(of: exam)
            isLoading = false
        } catch {
            errorOccured = true
        }
    }
}
