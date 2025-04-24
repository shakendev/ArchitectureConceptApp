import Foundation

struct PostDTO: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension PostDTO {
    func mapToModel() -> PostModel {
        .init(userID: userId, id: id, title: title, body: body)
    }
}
