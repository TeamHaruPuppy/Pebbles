import Foundation
import Alamofire

// MARK: - RockInfoModel
struct RockInfoModel: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: [RockInfoResult]
}

// MARK: - Result
struct RockInfoResult: Codable {
    let end: String
    let id: Int
    let name, start: String
}
