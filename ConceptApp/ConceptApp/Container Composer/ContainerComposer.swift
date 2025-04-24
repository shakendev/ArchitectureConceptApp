import Core
import MelonKit

@MainActor
enum ContainerComposer {
    static func compose() -> MLNContainer {
        let container = MLNContainer()

        container.register(NetworkConfig.self, as: .singleton) { _ in .init() }
        container.register(MLNNetworkManager.self, as: .singleton) { _ in .init(disconnectWhenVPNIsEnabled: true) }

        container.register(MLNHapticFeedback.self, as: .singleton) { _ in .init() }
        container.register(BasicHapticFeedback<MLNHapticFeedback>.self, as: .singleton) { resolver in
            let feedbackGenerator = resolver.resolve(MLNHapticFeedback.self)
            let hapticFeedback = BasicHapticFeedback(generator: feedbackGenerator)

            return hapticFeedback
        }

        return container
    }
}
