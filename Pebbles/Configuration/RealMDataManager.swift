import RealmSwift


class RealmManager {
    
    func getRealm(){
        let realm = try! Realm()
        
        do
        {
            try realm.write {
                let userData = realm.objects(UserHabit.self)
                
                var x = 0
                for idx in userData {
                    
                    //MARK: - realm에 저장된 날짜와, 앱 실행시키고 저장한 날짜가 다르면 리턴
                    if Date().text != idx.today{
                        print("저장된 날짜 : \(idx.today) | 앱 실행시킨 날짜 : \(Date().text)")
                        return;
                    }
                    
                    Constant.TODAY_DATA[x].id = idx.id
                    Constant.TODAY_DATA[x].name = idx.name
                    Constant.TODAY_DATA[x].todayStatus = idx.todayStatus
                    var y = 0
                    for idxOfTodo in idx.todos{
                        Constant.TODAY_DATA[x].todos[y].id = idxOfTodo.id
                        Constant.TODAY_DATA[x].todos[y].name = idxOfTodo.name
                        Constant.TODAY_DATA[x].todos[y].seq = idxOfTodo.seq
                        Constant.TODAY_DATA[x].todos[y].status = idxOfTodo.status
                        Constant.TODAY_DATA[x].todos[y].id = idxOfTodo.id
                    y += 1
                    }
                 x += 1
                }
                print("잘 파싱 되었닝?? : \(Constant.TODAY_DATA)")
            }
        } catch {
            print("잘 안되었는디요? : \(error.localizedDescription)")
        }
    }
    
    func saveRealm(){
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
        for idx in Constant.TODAY_DATA{
            let model = UserHabit()
            let realmUserTodo = List<UserTodo>()
            try! realm.write{
                for todo in idx.todos{
                    let TD = UserTodo(id: todo.id, name: todo.name, seq: todo.seq, status: todo.status)
                    realmUserTodo.append(TD)
                }
                model.today = idx.today
                model.id = idx.id
                model.name = idx.name
                model.todayStatus = idx.todayStatus
                model.todos = realmUserTodo
                realm.add(model)
            }
        }
        
    }
}
