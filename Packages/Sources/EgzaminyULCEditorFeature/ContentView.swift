import Dependencies
import Services
import SwiftUI

public struct ContentView: View {
    @Dependency(\.examsApiClient) private var examApiClient
    @Dependency(\.subjectAPIClient) private var subjectApiClient
    @Dependency(\.questionsAPIClient) private var questionApiClient

    public var body: some View {
        MainView()
            .environment(SceneState())
            .environment(
                ExamDataSource(
                    examApiClient: examApiClient,
                    subjectAPIClient: subjectApiClient,
                    questionsAPIClient: questionApiClient
                )
            )
            .frame(minWidth: 1100, minHeight: 660)
    }

    public init() {}
}

#Preview {
    ContentView()
}
