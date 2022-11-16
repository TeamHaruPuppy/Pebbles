
import Foundation
import Alamofire

// MARK: - HomeModel
struct HomeModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: HomeResult
}

// MARK: - Result
struct HomeResult: Codable {
    let today: String
    let habits: [Habit]
}

// MARK: - Habit
struct Habit: Codable {
    let id: Int
    let name, start, end: String
    let weeks: Weeks
    let today: String
    let consDays, seq: Int
    let todayStatus, status: Status
    let todos: [Todo]

    enum CodingKeys: String, CodingKey {
        case id, name, start, end, weeks, today
        case consDays = "cons_days"
        case seq
        case todayStatus = "today_status"
        case status, todos
    }
}

enum Status: String, Codable {
    case statusFalse = "False"
    case StatusTrue = "True"
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int
    let name: String
    let seq: Int
    let status: Status
}

// MARK: - Weeks
struct Weeks: Codable {
    let mon, tue, wed, thu, fri, sat, sun: Bool?
}
