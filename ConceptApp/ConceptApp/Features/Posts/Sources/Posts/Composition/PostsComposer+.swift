import SwiftUI

extension PostsComposer {
    public struct Context {
        let events: PostsEvents

        public init(events: PostsEvents) {
            self.events = events
        }
    }
}

extension PostsComposer {
    public struct Feature {
        public let screen: AnyView

        init(screen: some View) {
            self.screen = .init(screen)
        }
    }
}
