import RealmSwift
import Foundation

class UserHabit: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var todayStatus = ""
    @objc dynamic var today = ""
    var todos = List<UserTodo>()
    
    convenience init(id:Int, name:String, todayStatus: String) {
        self.init()
        self.id = id
        self.name = name
        self.todayStatus = todayStatus
    }
}

// MARK: - Todo
class UserTodo: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var seq = 0
    @objc dynamic var status = ""
    convenience init(id:Int, name:String, seq: Int, status: String) {
        self.init()
        self.id = id
        self.name = name
        self.seq = seq
        self.status = status
    }
    
}
