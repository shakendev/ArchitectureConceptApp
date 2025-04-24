import SharedUI
import SwiftUI

struct PostScreen<ViewModel: PostViewModellable>: View {
    @State private var viewModel: ViewModel
    private let events: PostEvents

    var body: some View {
        NavigationBar(title: "PFNavigationBarTitle", bundle: .module) {
            switch viewModel.postState {
            case .loading:
                PostLoadingView()
            case .connectionError:
                ConnectionErrorView(action: reloadPost)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loadingError:
                LoadingErrorView(action: reloadPost)
                    .onAppear { events.onHapticFeedback(.error) }
            case .loaded(let post):
                PostLoadedView(post: post, events: events) {
                    switch viewModel.commentsState {
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

    private func reloadPost() {
        events.onHapticFeedback(.light(intensity: .strong))

        Task(priority: .background) {
            await viewModel.reloadPost()
        }
    }

    private func reloadComments() {
        events.onHapticFeedback(.light(intensity: .strong))

        Task(priority: .background) {
            await viewModel.reloadComments()
        }
    }
}
