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
                if let title = exam.title {
                    Text(title)
                        .foregroundColor(.secondary)
                        .font(.largeTitle.weight(.bold))
                }
                if let subtitle = exam.subtitle {
                    Text(subtitle)
                        .foregroundColor(.primary)
                        .font(.footnote.weight(.semibold))
                }
                if let text = exam.text {
                    Text(text)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
            )
        }
        .applyGradientStroke(cornerRadius: 32)
        .background(
            backgroundImage
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        }
        .frame(height: 300)
        .enableInjection()
    }
    
    @ViewBuilder
    private var backgroundImage: some View {
        if let image = exam.image {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Rectangle().fill(.secondary.opacity(0.5))
        }
    }
}
