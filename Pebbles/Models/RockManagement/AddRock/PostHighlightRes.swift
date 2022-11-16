import Foundation
import Alamofire

// MARK: - PostHighlightRes
struct PostHighlightRes: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: PostHighlightResResult
}

// MARK: - Result
struct PostHighlightResResult: Codable {
    let habitsName: [String]
    let highlightName: String
    let todosName: [String]

    enum CodingKeys: String, CodingKey {
        case habitsName = "habits_name"
        case highlightName = "highlight_name"
        case todosName = "todos_name"
    }
}
