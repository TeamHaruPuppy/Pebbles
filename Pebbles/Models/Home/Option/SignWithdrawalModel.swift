import Foundation
import Alamofire

// MARK: - SignWithdrawalModel
struct SignWithdrawalModel: Codable {
    var code: Int
    var isSuccess: Bool
    var message: String
    var result : String?
}
