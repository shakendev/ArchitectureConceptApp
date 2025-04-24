import MelonKit

@MainActor
public struct PostComposer<Resolver: MLNResolvableContainer> {
    private let resolver: Resolver

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    public func compose(context: Context) -> Feature {
        let deps = PostDependencies(resolver: resolver)
        let viewModel = PostViewModel(id: context.id, fetcher: deps.fetcher)
        let screen = PostScreen(viewModel: viewModel, events: context.events)

        return .init(screen: screen)
    }
}
