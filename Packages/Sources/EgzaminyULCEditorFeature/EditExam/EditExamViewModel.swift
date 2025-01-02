import Observation
import SharedModels

@Observable
internal final class EditExamViewModel {
    internal var editExamForm: EditExamForm

    internal init(editExamForm: EditExamForm) {
        self.editExamForm = editExamForm
    }
    
    internal func updateExam() {
    
    }
}
