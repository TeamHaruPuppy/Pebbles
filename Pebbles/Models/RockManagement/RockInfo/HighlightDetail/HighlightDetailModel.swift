import Foundation
import Alamofire

// MARK: - HighlightDetailModel
struct HighlightDetailModel: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: HighlightDetailResult
}
// MARK: - Result
struct HighlightDetailResult: Codable {
    let end: String
    let getRockManageDetailHabitResList: [GetRockManageDetailHabitResList]
    let id: Int
    let name, start: String
}
// MARK: - GetRockManageDetailHabitResList
struct GetRockManageDetailHabitResList: Codable {
    let end: String
    let getRockManageDetailTodoResList: [GetRockManageDetailTodoResList]
    let id: Int
    let name: String
    let seq: Int
    let start: String
    // Weeks는 HomeModel에 이미 정의되어 있음
    let weeks: Weeks
}
// MARK: - GetRockManageDetailTodoResList
struct GetRockManageDetailTodoResList: Codable {
    let id: Int
    let name: String
    let seq: Int
}
