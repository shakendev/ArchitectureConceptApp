import Core
import Observation
import MelonKit

enum PostsState {
    case loading
    case connectionError
    case loadingError
    case loaded(PostsViewItems)
}

@MainActor
protocol PostsViewModellable: Observable {
    var state: PostsState { get }

    func loadPosts() async
    func reloadPosts() async
}

@Observable
final class PostsViewModel<RemoteFetcher: PostsRemoteFetchable>: PostsViewModellable {
    private(set) var state: PostsState = .loading

    @ObservationIgnored private var loadedPosts: Int = .zero
    @ObservationIgnored private var viewItems: PostsViewItems?

    private let fetcher: RemoteFetcher
    private let limitPosts = 10

    init(fetcher: RemoteFetcher) {
        self.fetcher = fetcher
    }

    func loadPosts() async {
        do {
            let model = try await fetcher.loadPosts(skip: loadedPosts, with: limitPosts)
            let viewItems = model.mapToViewItems()

            if self.viewItems.isNil {
                self.viewItems = viewItems
            } else {
                self.viewItems?.posts.append(contentsOf: viewItems.posts)
            }

            if let loadedViewItems = self.viewItems {
                loadedPosts += limitPosts
                state = .loaded(loadedViewItems)
            }
        } catch {
            state = switch error {
            case .vpnEnabled: .connectionError
            default: .loadingError
            }
        }
    }

    func reloadPosts() async {
        state = .loading
        loadedPosts = .zero
        viewItems = nil
        await loadPosts()
    }
}
