import Core
import Observation
import MelonKit

@MainActor
protocol PostsViewModellable: Observable, ScreenStateable {
    var viewItems: PostsViewItems? { get }

    func loadPosts() async
    func reloadPosts() async
}

@Observable
final class PostsViewModel<RemoteFetcher: PostsRemoteFetchable>: PostsViewModellable {
    private(set) var state: ScreenState = .loading
    @ObservationIgnored private(set) var viewItems: PostsViewItems?

    private let fetcher: RemoteFetcher

    init(fetcher: RemoteFetcher) {
        self.fetcher = fetcher
    }

    func loadPosts() async {
        do {
            let model = try await fetcher.loadPosts()
            let viewItems = model.mapToViewItems()

            self.viewItems = viewItems
            state = .loaded
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
