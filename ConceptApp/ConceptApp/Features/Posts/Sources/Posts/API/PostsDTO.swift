import Foundation

struct PostsDTO: Decodable {
    let posts: [Post]
    let total: Int
}

extension PostsDTO {
    struct Post: Decodable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
}

extension PostsDTO {
    func mapToModel() -> PostsModel {
        let posts = posts.map {
            PostsModel.Post(userID: $0.userId, id: $0.id, title: $0.title, body: $0.body)
        }

        return .init(posts: posts, total: total)
    }
}
