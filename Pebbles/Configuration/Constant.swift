import UIKit

//MARK: - Project 전체에서 공통으로 사용하는 값들
struct Constant {
    static var USER_JWTTOKEN = ""
    static var USER_ID = 0
    static var USER_NAME = ""
    static var USER_ONBOARDING = false
    static let BASE_URL = "http://umc-kyj.shop"
    static let edgeWidth = 375 / Device.width
    static let edgeHeight = 812 / Device.height
    static let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small)
    static let defaults = UserDefaults.standard
    
    //MARK: - Home 관련 데이터
    static var homeResult : HomeResult = HomeResult(today: "", habits: [])
    static var TODAY_DATA : [Habit] = []
    static var IS_VISIT_FIRST = true
    static var selectDay = ""
    static var selectFullDay = ""
    
    //MARK: - RockManagement 관련 데이터
    static var rockResult : [RockInfoResult] = []
    static var rockDetailResult = HighlightDetailResult(end: "", getRockManageDetailHabitResList: [], id: 0, name: "", start: "")
    
    
    //MARK: - POST할 때, 파라미터로 보내는 모델 객체
    static var POST_HIGHLIGHT = HighlightPostModel(end: "", habits: [], name: "", start: "")
    static var POST_HIGHLIGHT_RES = PostHighlightResResult(habitsName: [], highlightName: "", todosName: [])
    static var POST_ROCK_DATE : [Date : Date] = [:]
    static var POST_HABIT_DATE : Array = [Dictionary<Date, Date>]()
    static var HABIT_SEQ = 0
    
    //MARK: - home/addHighlight/addRock 변수
    static var rockStartDay = Date()
    static var rockEndDay = Date(year: 2099, month: 12, day: 31)
    // false : 시작 | true : 끝
    static var startOrEnd = false
    
    
    static func initConstantData(){
        
        Constant.USER_ID = 0
        Constant.USER_JWTTOKEN = ""
        Constant.USER_NAME = ""
        
        Constant.homeResult = HomeResult(today: "", habits: [])
        Constant.selectDay = ""
        Constant.selectFullDay = ""
        
        Constant.rockResult = []
        
        Constant.rockEndDay = Date()
        Constant.rockStartDay = Date()
        
        Constant.startOrEnd = false
    }
    
    
}
