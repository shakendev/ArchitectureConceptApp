import Foundation

struct CommentsModel {
    let comments: [Comment]
}

extension CommentsModel {
    struct Comment {
        let id: Int
        let name: String
        let email: String
        let body: String
    }
}

extension CommentsModel {
    func mapToViewItems() -> CommentsViewItems {
        let comments = comments.map {
            CommentsViewItems.Comment(id: $0.id, name: $0.name, email: $0.email, body: $0.body)
        }

        return .init(comments: comments)
    }
}
