import SharedUI
import SwiftUI
import MelonUI

struct PostLoadedView: View {
    private let post: PostViewItems
    private let comments: [CommentsViewItems.Comment]?
    private let events: PostEvents

    var body: some View {
        VStack(spacing: 20) {
            postView(post: post)
                .padding(.horizontal, 16)

            if let comments {
                VStack(alignment: .leading, spacing: .zero) {
                    MLNMarkdownText(separator: .empty, .text("PFCommentsSectionTitle", bundle: .module))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .black, design: .rounded))
                        .padding(.horizontal, 16)

                    List {
                        ForEach(comments.indices, id: \.self) { index in
                            let comment = comments[index]

                            commentView(comment: comment)
                        }
                    }
                    .listStyle(.plain)
                }
            } else {
                Spacer()
            }
        }
        .padding(.vertical, 10)
    }

    init(
        post: PostViewItems,
        comments: [CommentsViewItems.Comment]?,
        events: PostEvents
    ) {
        self.post = post
        self.comments = comments
        self.events = events
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

    private func commentView(comment: CommentsViewItems.Comment) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Text(comment.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)

                Text(comment.id.formatted())
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(comment.body)
                    .font(.system(size: 13, weight: .light, design: .rounded))
                    .multilineTextAlignment(.leading)

                Text(comment.email)
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
