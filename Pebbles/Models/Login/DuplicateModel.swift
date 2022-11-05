import Foundation
import Alamofire

// MARK: - DuplicateModel
struct DuplicateModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Bool
}
