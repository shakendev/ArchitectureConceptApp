import MelonUI
import SwiftUI

struct CommentsLoadedView: View {
    private let comments: [CommentsViewItems.Comment]

    var body: some View {
        if comments.isEmpty {
            MLNMarkdownText(separator: .empty, .text("PFCommentsIsNotExistTitle", bundle: .module))
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(comments.indices, id: \.self) { index in
                    let comment = comments[index]

                    commentView(comment: comment)
                }
            }
            .listStyle(.plain)
        }
    }

    init(comments: [CommentsViewItems.Comment]) {
        self.comments = comments
    }
}



// MARK: - UI

extension CommentsLoadedView {
    private func commentView(comment: CommentsViewItems.Comment) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                HStack(spacing: 10) {
                    Text(comment.fullname)

                    HStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)

                        Text(comment.likes.formatted())
                    }
                }
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

                Text(comment.username)
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
