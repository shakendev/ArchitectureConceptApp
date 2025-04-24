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
                ConnectionErrorView(action: reloadPosts)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loadingError:
                LoadingErrorView(action: reloadPosts)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loaded(let items):
                if !items.posts.isEmpty {
                    PostsLoadedView(posts: items.posts, events: events) {
                        await viewModel.loadPosts()
                    }
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

    private func reloadPosts() {
        events.onHapticFeedback(.light(intensity: .strong))

        Task(priority: .background) {
            await viewModel.reloadPosts()
        }
    }
}
