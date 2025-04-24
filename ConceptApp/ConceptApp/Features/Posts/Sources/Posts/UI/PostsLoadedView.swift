import SwiftUI

struct PostsLoadedView: View {
    private let posts: [PostsViewItems.Post]
    private let events: PostsEvents

    var body: some View {
        List {
            ForEach(posts.indices, id: \.self) { index in
                let post = posts[index]

                postView(post: post)
                    .onTapGesture {
                        events.onHapticFeedback(.selection)
                        events.onPostButtonTap(post.id)
                    }
            }
        }
    }

    init(posts: [PostsViewItems.Post], events: PostsEvents) {
        self.posts = posts
        self.events = events
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
