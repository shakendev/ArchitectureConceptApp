import Foundation

struct PostModel {
    let userID: Int
    let id: Int
    let title: String
    let body: String
}

extension PostModel {
    func mapToViewItems() -> PostViewItems {
        .init(userID: userID, id: id, title: title, body: body)
    }
}
