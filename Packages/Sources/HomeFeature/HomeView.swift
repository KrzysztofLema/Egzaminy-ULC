import ExamDetailFeature
import SharedModels
import SharedViews
import SwiftUI

public struct HomeView: View {
    @ObserveInjection private var iO

    public init() {}

    public var body: some View {
        ScrollView {
            VStack {
                ForEach(ExamMock.mock) { exam in
                    NavigationLink(destination: ExamDetailView(exam: exam)) {
                        ExamView(exam: exam)
                    }
                }
            }
        }
        .enableInjection()
    }
}
