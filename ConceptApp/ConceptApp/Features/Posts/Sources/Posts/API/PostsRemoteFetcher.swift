import Core
import Foundation
import MelonKit

@MainActor
protocol PostsRemoteFetchable: AnyObject {
    func loadPosts(skip skippedPosts: Int, with limit: Int) async throws(MLNNetworkError) -> PostsModel
}

final class PostsRemoteFetcher<Config: MLNNetworkConfigurable, Network: MLNNetworkManageable>: PostsRemoteFetchable {
    private let config: Config
    private let network: Network

    init(config: Config, network: Network) {
        self.config = config
        self.network = network
    }

    func loadPosts(skip skippedPosts: Int, with limit: Int) async throws(MLNNetworkError) -> PostsModel {
        let items = [
             URLQueryItem(name: "limit", value: "\(limit)"),
             URLQueryItem(name: "skip", value: "\(skippedPosts)")
        ]
        guard let url = config.getURL(for: .posts, using: items) else { throw .invalidURL }
        let headers = configureHeaders()

        do {
            let dto: PostsDTO = try await network.request(
                .get, timeout: HTTPTimeouts.url, for: url, with: headers, using: nil
            )

            return dto.mapToModel()
        } catch {
            throw error
        }
    }

    private func configureHeaders() -> [MLNNetworkManager.HTTPHeader] { [HTTPHeaders.contentType] }
}
