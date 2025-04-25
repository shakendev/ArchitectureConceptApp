import Core
import Foundation
import MelonKit

@MainActor
protocol CommentsRemoteFetchable: AnyObject {
    func loadComments(for postID: Int) async throws(MLNNetworkError) -> CommentsModel
}

final class CommentsRemoteFetcher<Config: MLNNetworkConfigurable, Network: MLNNetworkManageable>: CommentsRemoteFetchable {
    private let config: Config
    private let network: Network

    init(config: Config, network: Network) {
        self.config = config
        self.network = network
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
