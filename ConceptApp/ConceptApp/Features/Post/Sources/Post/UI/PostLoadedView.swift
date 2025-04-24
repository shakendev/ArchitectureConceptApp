import SharedUI
import SwiftUI
import MelonUI

struct PostLoadedView<Comments: View>: View {
    private let post: PostViewItems
    private let events: PostEvents

    private let comments: Comments

    var body: some View {
        VStack(spacing: 20) {
            postView(post: post)
                .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: .zero) {
                MLNMarkdownText(separator: .empty, .text("PFCommentsSectionTitle", bundle: .module))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .black, design: .rounded))
                    .padding(.horizontal, 16)

                comments
            }
        }
        .padding(.vertical, 10)
        .ignoresSafeArea()
    }

    init(
        post: PostViewItems,
        events: PostEvents,
        @ViewBuilder comments: () -> Comments
    ) {
        self.post = post
        self.events = events
        self.comments = comments()
    }
}



// MARK: - UI

extension PostLoadedView {
    private func postView(post: PostViewItems) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Text(post.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15, weight: .black, design: .rounded))
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
