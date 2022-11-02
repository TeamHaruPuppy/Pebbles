import Foundation
import Alamofire

// MARK: - HomeModel
struct HomeModel: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: HomeResult
}

// MARK: - Result
struct HomeResult: Codable {
    let habits: [Habit]
    let today: String
}

// MARK: - Habit
struct Habit: Codable {
    let consDays: Int
    let end: String
    let id: Int
    let name: String
    let seq: Int
    let start, status, today, todayStatus: String
    let todos: [Todo]
    let weeks: String

    enum CodingKeys: String, CodingKey {
        case consDays = "cons_days"
        case end, id, name, seq, start, status, today
        case todayStatus = "today_status"
        case todos, weeks
    }
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int
    let name: String
    let seq: Int
    let status: String
}
