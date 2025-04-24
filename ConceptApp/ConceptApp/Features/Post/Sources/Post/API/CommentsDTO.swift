import Foundation

struct CommentsDTO: Decodable {
    let comments: [Comment]
}

extension CommentsDTO {
    struct Comment: Decodable {
        let postId: Int
        let id: Int
        let body: String
        let likes: Int
        let user: User
    }
}

extension CommentsDTO {
    struct User: Decodable {
        let username: String
        let fullName: String
    }
}

extension CommentsDTO {
    func mapToModel() -> CommentsModel {
        let comments = comments.map {
            CommentsModel.Comment(
                    postID: $0.postId,
                    id: $0.id,
                    body: $0.body,
                    likes: $0.likes,
                    username: $0.user.username,
                    fullname: $0.user.fullName
            )
        }
        return .init(comments: comments)
    }
}
