import Foundation
import Alamofire

// MARK: - SignUpModel
struct SignUpModel: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: SignUpResult
}

// MARK: - Result
struct SignUpResult: Codable {
    let jwt: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case jwt
        case userID = "userId"
    }
}
