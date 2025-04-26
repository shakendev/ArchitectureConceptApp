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
            let loadedViewItems = model.mapToViewItems()

            if viewItems.isNil {
                viewItems = loadedViewItems
            } else {
                viewItems?.posts.append(contentsOf: loadedViewItems.posts)
            }

            if let viewItems = self.viewItems {
                loadedPosts += limitPosts
                state = .loaded(viewItems)
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
