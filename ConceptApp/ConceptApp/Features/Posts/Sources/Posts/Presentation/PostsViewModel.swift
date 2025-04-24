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

    private let fetcher: RemoteFetcher

    init(fetcher: RemoteFetcher) {
        self.fetcher = fetcher
    }

    func loadPosts() async {
        do {
            let model = try await fetcher.loadPosts()
            let viewItems = model.mapToViewItems()

            state = .loaded(viewItems)
        } catch {
            state = switch error {
            case .vpnEnabled: .connectionError
            default: .loadingError
            }
        }
    }

    func reloadPosts() async {
        state = .loading
        await loadPosts()
    }
}
