import SwiftUI

extension CommentsComposer {
    public struct Context {
        let id: Int
        let events: CommentsEvents

        public init(id: Int, events: CommentsEvents) {
            self.id = id
            self.events = events
        }
    }
}

extension CommentsComposer {
    public struct Feature {
        public let screen: AnyView

        init(screen: some View) {
            self.screen = .init(screen)
        }
    }
}
