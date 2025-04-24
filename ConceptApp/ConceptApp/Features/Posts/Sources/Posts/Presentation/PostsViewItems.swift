import Foundation

struct PostsViewItems {
    var posts: [Post]
}

extension PostsViewItems {
    struct Post {
        let userID: Int
        let id: Int
        let title: String
        let body: String
    }
}
