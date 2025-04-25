import SharedUI
import SwiftUI

struct PostScreen<ViewModel: PostViewModellable>: View {
    private let commentsScreen: AnyView
    @State private var viewModel: ViewModel
    private let events: PostEvents

    var body: some View {
        NavigationBar(title: "PFNavigationBarTitle", bundle: .module) {
            switch viewModel.state {
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
                    commentsScreen
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

    init(
        comments commentsScreen: AnyView,
        viewModel: ViewModel,
        events: PostEvents
    ) {
        self.commentsScreen = commentsScreen
        self.viewModel = viewModel
        self.events = events
    }

    private func reloadPost() {
        events.onHapticFeedback(.light(intensity: .strong))

        Task(priority: .background) {
            await viewModel.reloadPost()
        }
    }
}
