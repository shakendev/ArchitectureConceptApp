import SharedUI
import SwiftUI

struct CommentsScreen<ViewModel: CommentsViewModellable>: View {
    @State private var viewModel: ViewModel
    private let events: CommentsEvents

    var body: some View {
        BackgroundView {
            switch viewModel.state {
            case .loading:
                CommentsLoadingView()
            case .connectionError:
                ConnectionErrorView(action: reloadComments)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loadingError:
                LoadingErrorView(action: reloadComments)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loaded(let items):
                CommentsLoadedView(comments: items.comments)
            }
        }
        .onFirstTask(priority: .background) {
            await viewModel.loadComments()
        }
    }

    init(viewModel: ViewModel, events: CommentsEvents) {
        self.viewModel = viewModel
        self.events = events
    }

    private func reloadComments() {
        events.onHapticFeedback(.light(intensity: .strong))

        Task(priority: .background) {
            await viewModel.reloadComments()
        }
    }
}
