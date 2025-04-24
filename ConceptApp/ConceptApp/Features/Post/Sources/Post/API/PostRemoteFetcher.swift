import Core
import Foundation
import MelonKit

@MainActor
protocol PostRemoteFetchable: AnyObject {
    func loadPost(for postID: Int) async throws(MLNNetworkError) -> PostModel
    func loadComments(for postID: Int) async throws(MLNNetworkError) -> CommentsModel
}

final class PostRemoteFetcher<Config: MLNNetworkConfigurable, Network: MLNNetworkManageable>: PostRemoteFetchable {
    private let config: Config
    private let network: Network

    init(config: Config, network: Network) {
        self.config = config
        self.network = network
    }

    func loadPost(for postID: Int) async throws(MLNNetworkError) -> PostModel {
        let path = "/\(postID)"
        guard let url = config.getURL(for: .posts, appending: path) else { throw .invalidURL }
        let headers = configureHeaders()

        do {
            let dto: PostDTO = try await network.request(
                .get, timeout: HTTPTimeouts.url, for: url, with: headers, using: nil
            )

            return dto.mapToModel()
        } catch {
            throw error
        }
    }

    func loadComments(for postID: Int) async throws(MLNNetworkError) -> CommentsModel {
        let path = "\(postID)"
        guard let url = config.getURL(for: .comments, appending: path) else { throw .invalidURL }
        let headers = configureHeaders()

        do {
            let dto: CommentsDTO = try await network.request(
                .get, timeout: HTTPTimeouts.url, for: url, with: headers, using: nil
            )

            return dto.mapToModel()
        } catch {
            throw error
        }
    }

    private func configureHeaders() -> [MLNNetworkManager.HTTPHeader] { [HTTPHeaders.contentType] }
}
