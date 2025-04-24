import SharedUI
import SwiftUI

struct PostScreen<ViewModel: PostViewModellable>: View {
    @State private var viewModel: ViewModel
    private let events: PostEvents

    var body: some View {
        NavigationBar(title: "PFNavigationBarTitle", bundle: .module) {
            switch viewModel.state {
            case .loading:
                PostLoadingView()
            case .connectionError:
                ConnectionErrorView(action: reload)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loadingError:
                LoadingErrorView(action: reload)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loaded:
                if let post = viewModel.postViewItems {
                    PostLoadedView(
                        post: post,
                        comments: viewModel.commentsViewItems?.comments,
                        events: events
                    )
                    .onFirstTask(priority: .background) {
                        await viewModel.loadComments()
                    }
                } else {
                    PostEmptyView()
                }
            }
        } leadingBarItem: {
            Button {
                events.onHapticFeedback(.light(intensity: .medium))
                events.onBackButtonTap()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .aspectRatio(contentMode: .fit)
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationBarBackButtonHidden()
        .onFirstTask(priority: .background) {
            await viewModel.loadPost()
        }
    }

    init(viewModel: ViewModel, events: PostEvents) {
        self.viewModel = viewModel
        self.events = events
    }

    private func reload() {
        events.onHapticFeedback(.light(intensity: .strong))

        Task(priority: .background) {
            await viewModel.reloadPost()
        }
    }
}
