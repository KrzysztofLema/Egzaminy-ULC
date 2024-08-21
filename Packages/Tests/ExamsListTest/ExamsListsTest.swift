import ComposableArchitecture
import ExamDetailFeature
@testable import ExamsListFeature
import SharedModels
import TestExtensions

@MainActor
final class ExamsListsTest: XCTestCase {
    func testInitialNoArgumentsStore() {
        let store = TestStore(initialState: ExamsList.State()) {
            ExamsList()
        } withDependencies: {
            $0.examsClient.exams = { [] }
        }

        XCTAssertTrue(store.state.exams.count == 0)
    }

    func testGoToDetailExam() async {
        let examMock = Exam.mock1

        let store = TestStore(initialState: ExamsList.State()) {
            ExamsList()
        } withDependencies: {
            $0.examsClient.exams = { [examMock] }
        }

        XCTAssertTrue(store.state.exams.count == 1)

        await store.send(.examDetailButtonTapped(examMock)) {
            $0.path[id: 0] = .examDetailView(ExamDetail.State(exam: examMock))
        }
    }

    func testGoToDetailProperExam() async {
        let examMock = Exam.mock1
        let examMock2 = Exam.mock2

        let store = TestStore(initialState: ExamsList.State()) {
            ExamsList()
        } withDependencies: {
            $0.examsClient.exams = { [examMock, examMock2] }
        }

        XCTAssertTrue(store.state.exams.count == 2)

        await store.send(.examDetailButtonTapped(examMock2)) {
            $0.path[id: 0] = .examDetailView(ExamDetail.State(exam: examMock2))
        }
    }
}
