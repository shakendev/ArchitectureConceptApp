import MelonKit
import SwiftUI

import Comments

@MainActor
public struct PostComposer<Resolver: MLNResolvableContainer> {
    private let resolver: Resolver
    private let deps: PostDependencies

    public init(resolver: Resolver) {
        self.resolver = resolver
        deps = .init(resolver: resolver)
    }

    public func compose(context: Context) -> Feature {
        let viewModel = PostViewModel(id: context.id, fetcher: deps.fetcher)
        let commentsScreen = composeCommentsScreen(id: context.id)
        let screen = PostScreen(
            comments: commentsScreen,
            viewModel: viewModel,
            events: context.events
        )

        return .init(screen: screen)
    }

    private func composeCommentsScreen(id: Int) -> AnyView {
        let composer = CommentsComposer(resolver: resolver)
        let events = CommentsEvents(onHapticFeedback: deps.feedback.generate)
        let feature = composer.compose(context: .init(id: id, events: events))

        return feature.screen
    }
}
