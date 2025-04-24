import SwiftUI
import SharedUI

struct PostsScreen<ViewModel: PostsViewModellable>: View {
    @State private var viewModel: ViewModel
    private let events: PostsEvents

    var body: some View {
        NavigationBar(title: "PFNavigationBarTitle", bundle: .module) {
            switch viewModel.state {
            case .loading:
                PostsLoadingView()
            case .connectionError:
                ConnectionErrorView(action: reload)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loadingError:
                LoadingErrorView(action: reload)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loaded:
                if let posts = viewModel.viewItems?.posts, !posts.isEmpty {
                    PostsLoadedView(posts: posts, events: events)
                } else {
                    PostsEmptyView()
                }
            }
        }
        .onFirstTask(priority: .background) {
            await viewModel.loadPosts()
        }
    }

    init(viewModel: ViewModel, events: PostsEvents) {
        self.viewModel = viewModel
        self.events = events
    }

    private func reload() {
        events.onHapticFeedback(.light(intensity: .strong))

        Task(priority: .background) {
            await viewModel.reloadPosts()
        }
    }
}
