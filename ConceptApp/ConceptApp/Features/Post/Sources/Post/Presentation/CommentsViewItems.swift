import Foundation

struct CommentsViewItems {
    let comments: [Comment]
}

extension CommentsViewItems {
    struct Comment {
        let id: Int
        let name: String
        let email: String
        let body: String
    }
}
