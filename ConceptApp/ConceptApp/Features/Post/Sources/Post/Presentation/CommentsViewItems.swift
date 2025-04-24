import Foundation

struct CommentsViewItems {
    let comments: [Comment]
}

extension CommentsViewItems {
    struct Comment {
        let postID: Int
        let id: Int
        let body :String
        let likes: Int
        let username: String
        let fullname: String
    }
}
