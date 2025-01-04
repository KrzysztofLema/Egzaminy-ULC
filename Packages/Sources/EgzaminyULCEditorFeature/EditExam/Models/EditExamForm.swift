import Foundation
import Helpers
import SharedModels

struct EditExamForm: Equatable, Sendable {
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var logo: String

    init(exam: Exam) {
        title = exam.title ?? .empty
        subtitle = exam.subtitle ?? .empty
        text = exam.text ?? .empty
        image = exam.image ?? .empty
        background = exam.background ?? .empty
        logo = exam.logo ?? .empty
    }
}
