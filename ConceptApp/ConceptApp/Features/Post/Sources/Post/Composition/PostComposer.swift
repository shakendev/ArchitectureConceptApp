import MelonKit
import SwiftUI

import Comments

@MainActor
public struct PostComposer<Resolver: MLNResolvableContainer> {
    private let resolver: Resolver

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    public func compose(context: Context) -> Feature {
        let deps = PostDependencies(resolver: resolver)
        let viewModel = PostViewModel(id: context.id, fetcher: deps.fetcher)
        let commentsScreen = composeCommentsScreen(id: context.id, event: context.events.onHapticFeedback)
        let screen = PostScreen(comments: commentsScreen, viewModel: viewModel, events: context.events)

        return .init(screen: screen)
    }

    private func composeCommentsScreen(id: Int, event: @escaping PostEvents.FeedbackAction) -> AnyView {
        let composer = CommentsComposer(resolver: resolver)
        let events = CommentsEvents(onHapticFeedback: event)
        let feature = composer.compose(context: .init(id: id, events: events))

        return feature.screen
    }
}
