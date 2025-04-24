import Foundation

struct CommentsModel {
    let comments: [Comment]
}

extension CommentsModel {
    struct Comment {
        let postID: Int
        let id: Int
        let body :String
        let likes: Int
        let username: String
        let fullname: String
    }
}

extension CommentsModel {
    func mapToViewItems() -> CommentsViewItems {
        let comments = comments.map {
            CommentsViewItems.Comment(
                postID: $0.postID,
                id: $0.id,
                body: $0.body,
                likes: $0.likes,
                username: "@\($0.username)",
                fullname: $0.fullname
            )
        }

        return .init(comments: comments)
    }
}
