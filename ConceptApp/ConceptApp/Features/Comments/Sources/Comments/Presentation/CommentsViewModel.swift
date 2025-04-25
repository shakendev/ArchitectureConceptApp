import Core
import Observation
import MelonKit

enum CommentsState {
    case loading
    case connectionError
    case loadingError
    case loaded(CommentsViewItems)
}

@MainActor
protocol CommentsViewModellable: Observable {
    var state: CommentsState { get }

    func loadComments() async
    func reloadComments() async
}

@Observable
final class CommentsViewModel<RemoteFetcher: CommentsRemoteFetchable>: CommentsViewModellable {
    private(set) var state: CommentsState = .loading

    private let postID: Int
    private let fetcher: RemoteFetcher

    init(id postID: Int, fetcher: RemoteFetcher) {
        self.postID = postID
        self.fetcher = fetcher
    }

    func loadComments() async {
        do {
            let model = try await fetcher.loadComments(for: postID)
            let viewItems = model.mapToViewItems()

            state = .loaded(viewItems)
        } catch {
            state = switch error {
            case .vpnEnabled: .connectionError
            default: .loadingError
            }
        }
    }

    func reloadComments() async {
        state = .loading
        await loadComments()
    }
}
