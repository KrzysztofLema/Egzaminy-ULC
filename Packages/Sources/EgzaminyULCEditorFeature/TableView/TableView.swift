import SwiftUI

struct TableView: View {
    private var viewModel = TableViewModel()

    var body: some View {
        Text("Here is your table")
    }

    init(viewModel: TableViewModel = TableViewModel()) {
        self.viewModel = viewModel
    }
}
