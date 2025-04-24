import SwiftUI

extension PostComposer {
    public struct Context {
        let id: Int
        let events: PostEvents

        public init(id: Int, events: PostEvents) {
            self.id = id
            self.events = events
        }
    }
}

extension PostComposer {
    public struct Feature {
        public let screen: AnyView

        init(screen: some View) {
            self.screen = .init(screen)
        }
    }
}
