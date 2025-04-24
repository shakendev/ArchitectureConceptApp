import Core
import Observation
import MelonKit

@MainActor
protocol PostViewModellable: Observable, ScreenStateable {
    var postViewItems: PostViewItems? { get }
    var commentsViewItems: CommentsViewItems? { get }

    func loadPost() async
    func reloadPost() async
    func loadComments() async
}

@Observable
final class PostViewModel<RemoteFetcher: PostRemoteFetchable>: PostViewModellable {
    private(set) var state: ScreenState = .loading
    @ObservationIgnored private(set) var postViewItems: PostViewItems?
    private(set) var commentsViewItems: CommentsViewItems?

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

            postViewItems = viewItems
            state = .loaded
        } catch {
            state = switch error {
            case .vpnEnabled: .connectionError
            default: .loadingError
            }
        }
    }

    func reloadPost() async {
        state = .loading
        await loadPost()
    }

    func loadComments() async {
        let model = try? await fetcher.loadComments(for: postID)
        let viewItems = model?.mapToViewItems()

        commentsViewItems = viewItems
    }
}
