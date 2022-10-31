import Foundation
import Alamofire

// MARK: - SignInnModel
struct SignInModel: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: SignInResult
}

// MARK: - Result
struct SignInResult: Codable {
    let jwt: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case jwt
        case userID = "userId"
    }
}
