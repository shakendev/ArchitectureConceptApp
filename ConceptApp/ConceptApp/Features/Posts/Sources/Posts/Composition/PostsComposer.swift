import MelonKit

@MainActor
public struct PostsComposer<Resolver: MLNResolvableContainer> {
    private let resolver: Resolver

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    public func compose(context: Context) -> Feature {
        let deps = PostsDependencies(resolver: resolver)
        let viewModel = PostsViewModel(fetcher: deps.fetcher)
        let screen = PostsScreen(viewModel: viewModel, events: context.events)

        return .init(screen: screen)
    }
}
