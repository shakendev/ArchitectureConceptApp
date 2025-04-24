import SwiftUI

struct PostsLoadedView: View {
    typealias Action = () async -> Void

    private let posts: [PostsViewItems.Post]
    private let events: PostsEvents
    private let action: Action

    var body: some View {
        List {
            ForEach(posts.indices, id: \.self) { index in
                let post = posts[index]

                postView(post: post)
                    .contentShape(.rect)
                    .onTapGesture {
                        events.onHapticFeedback(.selection)
                        events.onPostButtonTap(post.id)
                    }
                    .onFirstTask(priority: .background) {
                        guard index == (posts.count - 1) else { return }

                        await action()
                    }
            }
        }
    }

    init(
        posts: [PostsViewItems.Post],
        events: PostsEvents,
        load action: @escaping Action
    ) {
        self.posts = posts
        self.events = events
        self.action = action
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
