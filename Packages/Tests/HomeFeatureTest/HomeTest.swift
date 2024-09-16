import ComposableArchitecture
@testable import HomeFeature
import TestExtensions

final class HomeTests: XCTestCase {
    func testBasicsSelectedTab() async {
        let store = await TestStore(initialState: Home.State()) {
            Home()
        } withDependencies: {
            $0.examsClient = .testValue
            $0.userSettings = .testValue
            $0.diagnosticClient = .testValue
            $0.coreData = .testValue
        }

        await MainActor.run {
            XCTAssertTrue(store.state.selectedTab == .exams)
        }

        await store.send(.onTabSelection(.settings)) {
            $0.selectedTab = .settings
        }

        await store.send(.onTabSelection(.exams)) {
            $0.selectedTab = .exams
        }
    }
}
