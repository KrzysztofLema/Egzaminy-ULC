import ComposableArchitecture
import ExamDetailFeature
@testable import ExamsListFeature
import SharedModels
import TestExtensions

final class ExamsListsTest: XCTestCase {
    func testInitialNoArgumentsStore() {
        let store = TestStore(initialState: ExamsList.State()) {
            ExamsList()
        } withDependencies: {
            $0.examsClient.exams = { [] }
        }

        XCTAssertTrue(store.state.exams.isEmpty)
    }

    func testGoToDetailExam() async {
        let examMock = Exam.mock1

        let store = await TestStore(initialState: ExamsList.State()) {
            ExamsList()
        } withDependencies: {
            $0.examsClient.exams = { [examMock] }
            $0.coreData.fetchAllExams = { [examMock] }
        }

        await MainActor.run {
            XCTAssertTrue(store.state.exams.count == 1)
        }

        await store.send(.examDetailButtonTapped(examMock)) {
            $0.path[id: 0] = .examDetailView(ExamDetail.State(exam: examMock))
        }
    }

    func testGoToDetailProperExam() async {
        let examMock = Exam.mock1
        let examMock2 = Exam.mock2

        let store = await TestStore(initialState: ExamsList.State()) {
            ExamsList()
        } withDependencies: {
            $0.examsClient.exams = { [examMock, examMock2] }
            $0.coreData.fetchAllExams = { [examMock, examMock2] }
        }

        await MainActor.run {
            XCTAssertTrue(store.state.exams.count == 2)
        }

        await store.send(.examDetailButtonTapped(examMock2)) {
            $0.path[id: 0] = .examDetailView(ExamDetail.State(exam: examMock2))
        }
    }
}
