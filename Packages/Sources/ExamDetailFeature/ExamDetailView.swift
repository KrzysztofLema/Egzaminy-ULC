import CoreUI
import SharedModels
import SharedViews
import SwiftUI

public struct ExamDetailView: View {
    @ObserveInjection private var iO
    @Environment(\.dismiss) var dismiss

    let exam: Exam

    public var body: some View {
        ScrollView {
            VStack {
                Image(exam.image)
                    .resizable()
                    .scaledToFill()
                    .shadow(radius: 20)
                    .cornerRadius(30.0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black.opacity(0.2))
                    }
                    .strokeStyle(cornerRadius: 30)

                Text("Wybierz przedmiot:".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                ForEach(exam.subjects) { subject in
                    NavigationLink {
                        Text(subject.title)
                    } label: {
                        SubjectView(subject: subject)
                    }
                }
            }
        }
        .enableInjection()
    }

    public init(exam: Exam) {
        self.exam = exam
    }
}

extension UIApplication {
    static var safeAreaTopInset: CGFloat {
        UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive && $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?.windows
            .first { $0.isKeyWindow }?
            .safeAreaInsets.top ?? 0
    }
}
