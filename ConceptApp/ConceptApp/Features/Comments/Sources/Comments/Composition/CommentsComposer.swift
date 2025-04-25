import MelonKit

@MainActor
public struct CommentsComposer<Resolver: MLNResolvableContainer> {
    private let resolver: Resolver

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    public func compose(context: Context) -> Feature {
        let deps = CommentsDependencies(resolver: resolver)
        let viewModel = CommentsViewModel(id: context.id, fetcher: deps.fetcher)
        let screen = CommentsScreen(viewModel: viewModel, events: context.events)

        return .init(screen: screen)
    }
}
