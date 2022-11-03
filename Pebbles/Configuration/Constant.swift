import UIKit

//MARK: - Project 전체에서 공통으로 사용하는 값들
struct Constant {
    static var USER_JWTTOKEN = "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY2NzM4ODg2MCwiZXhwIjoxNjY4MjUyODYwfQ.J4_l6zqFmvPEHxfkCQ7IB82LE6ztfGt9qR6L3DvA4PU"
    static var USER_ID = 1
    static let BASE_URL = "http://umc-kyj.shop"
    static let edgeWidth = 375 / Device.width
    static let edgeHeight = 812 / Device.height
    static let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .small)
    
    
    //MARK: - Home 관련 데이터
    static var homeResult : HomeResult = HomeResult(habits: [], today: "")
    static var selectDay = ""
}

