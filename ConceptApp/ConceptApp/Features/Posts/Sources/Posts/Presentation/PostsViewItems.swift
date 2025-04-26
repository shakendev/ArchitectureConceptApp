import Foundation

struct PostsViewItems {
    var posts: [Post]
    let total: Int
}

extension PostsViewItems {
    struct Post {
        let userID: Int
        let id: Int
        let title: String
        let body: String
    }
}

extension PostsViewItems? {
    var isNil: Bool { self == nil }
}
