import SharedModels
import SharedViews
import SwiftUI

public struct HomeView: View {
    @ObserveInjection private var iO

    public init() {}

    public var body: some View {
        ScrollView {
            VStack {
                Text("Kursy".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                ForEach(exams) { exam in
                    ExamView(exam: exam)
                }
            }
        }
        .enableInjection()
    }
}
