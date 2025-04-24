import Core
import Observation
import MelonKit

enum PostState {
    case loading
    case connectionError
    case loadingError
    case loaded(PostViewItems)
}

enum CommentsState {
    case loading
    case connectionError
    case loadingError
    case loaded(CommentsViewItems)
}

@MainActor
protocol PostViewModellable: Observable {
    var postState: PostState { get }
    var commentsState: CommentsState { get }

    func loadPost() async
    func reloadPost() async
    func loadComments() async
    func reloadComments() async
}

@Observable
final class PostViewModel<RemoteFetcher: PostRemoteFetchable>: PostViewModellable {
    private(set) var postState: PostState = .loading
    private(set) var commentsState: CommentsState = .loading

    private let postID: Int
    private let fetcher: RemoteFetcher

    init(id postID: Int, fetcher: RemoteFetcher) {
        self.postID = postID
        self.fetcher = fetcher
    }

    func loadPost() async {
        do {
            let model = try await fetcher.loadPost(for: postID)
            let viewItems = model.mapToViewItems()

            postState = .loaded(viewItems)
        } catch {
            postState = switch error {
            case .vpnEnabled: .connectionError
            default: .loadingError
            }
        }
    }

    func reloadPost() async {
        postState = .loading
        await loadPost()
    }

    func loadComments() async {
        do {
            let model = try await fetcher.loadComments(for: postID)
            let viewItems = model.mapToViewItems()

            commentsState = .loaded(viewItems)
        } catch {
            commentsState = switch error {
            case .vpnEnabled: .connectionError
            default: .loadingError
            }
        }
    }

    func reloadComments() async {
        commentsState = .loading
        await loadComments()
    }
}
