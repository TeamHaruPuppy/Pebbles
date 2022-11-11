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
    
    
    //MARK: - Home 관련 데이터
    static var homeResult : HomeResult = HomeResult(habits: [], today: "")
    static var selectDay = ""
    static var selectFullDay = ""
    
    //MARK: - RockManagement 관련 데이터
    static var rockResult : [RockInfoResult] = []
    
    
    //MARK: - POST할 때, 파라미터로 보내는 모델 객체
    static var POST_HIGHLIGHT = HighlightPostModel(end: "", habits: [], name: "", start: "")
    
    //MARK: - home/addHighlight/addRock 변수
    static var rockStartDay = Date()
    static var rockEndDay = Date()
    // false : 시작 | true : 끝
    static var startOrEnd = false
    
    static var goalStatus = false
    static var startStatus = false
    static var endStatus = false
    
    //MARK: - home/addHighlight/addPebble 변수
    static var HABIT_COUNT = 1
    
    static func initConstantData(){
        
        Constant.USER_ID = 0
        Constant.USER_JWTTOKEN = ""
        Constant.USER_NAME = ""
        
        Constant.homeResult = HomeResult(habits: [], today: "")
        Constant.selectDay = ""
        Constant.selectFullDay = ""
        
        Constant.rockResult = []
        
        Constant.rockEndDay = Date()
        Constant.rockStartDay = Date()
        
        Constant.startOrEnd = false
        Constant.goalStatus = false
        Constant.startStatus = false
        Constant.endStatus = false
    }
    
}
