import SwiftUI

struct PostsLoadedView: View {
    typealias Action = () async -> Void

    private let items: PostsViewItems
    private let events: PostsEvents
    private let loadAction: Action

    var body: some View {
        List {
            let posts = items.posts

            ForEach(posts.indices, id: \.self) { index in
                let post = posts[index]

                postView(post: post)
                    .contentShape(.rect)
                    .onTapGesture {
                        events.onHapticFeedback(.selection)
                        events.onPostButtonTap(post.id)
                    }
                    .onFirstTask(priority: .background) {
                        guard posts.count < items.total, index == (posts.count - 1) else { return }

                        await loadAction()
                    }
            }
        }
    }

    init(
        items: PostsViewItems,
        events: PostsEvents,
        load loadAction: @escaping Action
    ) {
        self.items = items
        self.events = events
        self.loadAction = loadAction
    }
}



// MARK: - UI

extension PostsLoadedView {
    private func postView(post: PostsViewItems.Post) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Text(post.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)

                Text(post.id.formatted())
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
            }

            Text(post.body)
                .font(.system(size: 13, weight: .light, design: .rounded))
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
