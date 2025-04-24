//
//  ConceptAppApp.swift
//  ConceptApp
//
//  Created by Dimka Novikov on 24.04.2025.
//

import Core
import MelonKit
import MelonUI
import SwiftUI

import Post
import Posts

@main
struct ConceptAppApp: App {
    let container = ContainerComposer.compose()
    private let stackStore = MLNNavigationStackStore()
    private var screen: MLNNavigationStack!

    var body: some Scene {
        WindowGroup {
            screen
        }
    }

    init() {
        screen = composePostsScreen()
    }

    private func composePostsScreen() -> MLNNavigationStack {
        let composer = PostsComposer(resolver: container)
        let feedback = container.resolve(BasicHapticFeedback<MLNHapticFeedback>.self)
        let events = PostsEvents(
            onHapticFeedback: feedback.generate,
            onPostButtonTap: composePostScreen
        )
        let feature = composer.compose(context: .init(events: events))
        let item = MLNNavigationStackItem(view: feature.screen)

        stackStore.set(root: item)

        return .init(store: stackStore)
    }

    private func composePostScreen(id: Int) {
        let composer = PostComposer(resolver: container)
        let feedback = container.resolve(BasicHapticFeedback<MLNHapticFeedback>.self)
        let events = PostEvents(onHapticFeedback: feedback.generate) { stackStore.pop() }
        let feature = composer.compose(context: .init(id: id, events: events))
        let item = MLNNavigationStackItem(view: feature.screen)

        stackStore.push(item)
    }
}
