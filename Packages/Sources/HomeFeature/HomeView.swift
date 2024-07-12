import SharedViews
import SwiftUI

public struct HomeView: View {
    @ObserveInjection private var iO
    var model: HomeModel

    public init(model: HomeModel) {
        self.model = model
    }

    public var body: some View {
        VStack {
            Text("Swifty Stack!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            Menu(content: {
                ForEach(Array(Filter.Kind.allCases), id: \.rawValue) { kind in
                    Text(kind.rawValue)
                }
            }, label: {
                Label("Filter", systemImage: "plus")
                    .bold()
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            List(model.posts) { post in
                PostView(model: post, animationSettings: model.animationSettings)
            }
            .listStyle(.plain)
        }
        .task {
            await model.onAppear()
        }
        .enableInjection()
    }
}
