import Foundation

struct PostsModel {
    let posts: [Post]
    let total: Int
}

extension PostsModel {
    struct Post {
        let userID: Int
        let id: Int
        let title: String
        let body: String
    }
}

extension PostsModel {
    func mapToViewItems() -> PostsViewItems {
        let posts = posts.map {
            PostsViewItems.Post(userID: $0.userID, id: $0.id, title: $0.title, body: $0.body)
        }

        return .init(posts: posts, total: total)
    }
}
