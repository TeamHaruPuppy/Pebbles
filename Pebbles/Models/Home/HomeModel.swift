
import Foundation
import Alamofire

// MARK: - HomeModel
struct HomeModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    var result: HomeResult
}

// MARK: - Result
struct HomeResult: Codable {
    var today: String
    var habits: [Habit]
}

// MARK: - Habit
struct Habit: Codable {
    var id: Int
    var name, start, end: String
    var weeks: Weeks
    var today: String
    var consDays, seq: Int
    var todayStatus, status: String
    var todos: [Todo]

    enum CodingKeys: String, CodingKey {
        case id, name, start, end, weeks, today
        case consDays = "cons_days"
        case seq
        case todayStatus = "today_status"
        case status, todos
    }
}

// MARK: - Todo
struct Todo: Codable {
    var id: Int
    var name: String
    var seq: Int
    var status: String
}

// MARK: - Weeks
struct Weeks: Codable {
    var mon, tue, wed, thu, fri, sat, sun: Bool
}
