import SharedModels
import SharedViews
import SwiftUI

struct SubjectView: View {
    @ObserveInjection private var iO
    let subject: Subject

    var body: some View {
        HStack {
            Image(systemName: subject.image)
                .resizable()
                .foregroundColor(.primary)
                .frame(width: 32.0, height: 32.0)
                .padding(5)

            VStack(alignment: .leading, spacing: 12) {
                Text(subject.title)
                    .foregroundColor(.primary)
                    .font(.headline)

                HStack {
                    Text("60")
                    ProgressView(value: 60, total: 120)
                    Text("120")
                }
                .foregroundColor(.secondary)
                .font(.footnote)
            }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            Rectangle().fill(.ultraThinMaterial).mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        )

        .enableInjection()
    }
}
