import Core
import MelonKit

@MainActor
protocol PostsRemoteFetchable: AnyObject {
    func loadPosts() async throws(MLNNetworkError) -> PostsModel
}

final class PostsRemoteFetcher<Config: MLNNetworkConfigurable, Network: MLNNetworkManageable>: PostsRemoteFetchable {
    private let config: Config
    private let network: Network

    init(config: Config, network: Network) {
        self.config = config
        self.network = network
    }

    func loadPosts() async throws(MLNNetworkError) -> PostsModel {
        guard let url = config.getURL(for: .posts) else { throw .invalidURL }
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
