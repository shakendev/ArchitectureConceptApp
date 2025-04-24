import SwiftUI

struct CommentsLoadedView: View {
    private let comments: [CommentsViewItems.Comment]

    var body: some View {
        List {
            ForEach(comments.indices, id: \.self) { index in
                let comment = comments[index]

                commentView(comment: comment)
            }
        }
        .listStyle(.plain)
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
