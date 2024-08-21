import ComposableArchitecture
@testable import HomeFeature
import TestExtensions

@MainActor
final class HomeTests: XCTestCase {
    func testBasicsSelectedTab() async {
        let store = TestStore(initialState: Home.State()) {
            Home()
        } withDependencies: {
            $0.examsClient = .testValue
        }

        XCTAssertTrue(store.state.selectedTab == .exams)

        await store.send(.onTabSelection(.settings)) {
            $0.selectedTab = .settings
        }

        await store.send(.onTabSelection(.exams)) {
            $0.selectedTab = .exams
        }
    }
}
