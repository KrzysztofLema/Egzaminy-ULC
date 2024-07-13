import SharedModels
import SharedViews
import SwiftUI

struct ExamView: View {
    @ObserveInjection var iO
    var exam: Exam

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(exam.title)
                    .font(.largeTitle.weight(.bold))

                Text(exam.subtitle)
                    .font(.footnote.weight(.semibold))

                Text(exam.text)
                    .font(.footnote)
            }
            .padding(20)
            .background(
                Rectangle().fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
            )
        }
        .background(
            Image(exam.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        }
        .frame(height: 300)

        .enableInjection()
    }
}
