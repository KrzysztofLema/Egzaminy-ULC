import SharedModels
import SwiftUI

struct EditExamView: View {
    @Environment(\.dismiss) private var dismiss

    @State var editExamForm: EditExamForm

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            title
            editTitle
            editSubtitle
            editText
            editImage
            editBackground
            editLogo
            buttons
        }
        .frame(
            minWidth: 640,
            minHeight: 480
        )
        .padding()
    }

    private var title: some View {
        Text("Edit exam")
            .font(.headline)
    }

    private var editTitle: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.subheadline)
                .bold()
            TextField("Exam title", text: $editExamForm.title)
        }
    }

    private var editSubtitle: some View {
        VStack(alignment: .leading) {
            Text("Subtitle")
                .font(.subheadline)
                .bold()
            TextField("Exam subtitle", text: $editExamForm.subtitle)
        }
    }

    private var editText: some View {
        VStack(alignment: .leading) {
            Text("Text")
                .font(.subheadline)
                .bold()
            TextEditor(text: $editExamForm.text)
        }
    }

    private var editImage: some View {
        VStack(alignment: .leading) {
            Text("Image")
                .font(.subheadline)
                .bold()
            TextField("Exam image", text: $editExamForm.image)
        }
    }

    private var editBackground: some View {
        VStack(alignment: .leading) {
            Text("Background")
                .font(.subheadline)
                .bold()
            TextField("Exam background", text: $editExamForm.background)
        }
    }

    private var editLogo: some View {
        VStack(alignment: .leading) {
            Text("Logo")
                .font(.subheadline)
                .bold()
            TextField("Exam logo", text: $editExamForm.logo)
        }
    }

    private var buttons: some View {
        HStack {
            Spacer()
            dismissButton
            saveButton
        }
    }

    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Dismiss")
        }
    }

    private var saveButton: some View {
        Button {
            #warning("Save exam")
            dismiss()
        } label: {
            Text("Save")
        }
    }
}
