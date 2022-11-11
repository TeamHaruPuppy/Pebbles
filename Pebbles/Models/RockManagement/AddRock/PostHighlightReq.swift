import Foundation
import Alamofire

// MARK: - HighlightPostModel   => 내가 파라미터로 보낼 모델

struct HighlightPostModel: Codable {
    var end: String
    var habits: [ReqHabit]
    var name, start: String
}

// MARK: - Habit
struct ReqHabit: Codable {
    var days: [String]
    var end, name: String
    var seq: Int
    var start: String
    var todos: [ReqTodo]
    var weeks: ReqWeeks
}


// MARK: - Todo
struct ReqTodo: Codable {
    var name: String
    var seq: Int
}



// MARK: - Weeks
struct ReqWeeks: Codable {
    var fri, mon, sat, sun: Bool
    var thu, tue, wed: Bool
}
