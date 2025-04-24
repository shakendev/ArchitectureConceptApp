import Core
import MelonKit

@MainActor
struct PostDependencies {
    let fetcher: PostRemoteFetcher<NetworkConfig, MLNNetworkManager>

    init<Resolver: MLNResolvableContainer>(resolver: Resolver) {
        let config = resolver.resolve(NetworkConfig.self)
        let network = resolver.resolve(MLNNetworkManager.self)

        fetcher = .init(config: config, network: network)
    }
}
