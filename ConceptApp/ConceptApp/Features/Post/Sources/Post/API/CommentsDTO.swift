import Foundation

typealias CommentsDTO = [CommentDTO]

struct CommentDTO: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

extension CommentsDTO {
    func mapToModel() -> CommentsModel {
        let comments = self.map {
            CommentsModel.Comment(id: $0.id, name: $0.name, email: $0.email, body: $0.body)
        }

        return .init(comments: comments)
    }
}
