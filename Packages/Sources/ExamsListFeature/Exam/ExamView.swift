import ComposableArchitecture
import CoreUI
import SharedModels
import SharedViews
import SwiftUI

struct ExamView: View {
    @ObserveInjection var iO
    var exam: Exam

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text(exam.title ?? "")
                    .foregroundColor(.secondary)
                    .font(.largeTitle.weight(.bold))

                Text(exam.subtitle ?? "")
                    .foregroundColor(.primary)
                    .font(.footnote.weight(.semibold))

                Text(exam.text ?? "")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
            }
            .padding(20)
            .background(
                Rectangle().fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
            )
        }
        .strokeStyle(cornerRadius: 32)
        .background(
            Image(exam.image ?? "")
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
