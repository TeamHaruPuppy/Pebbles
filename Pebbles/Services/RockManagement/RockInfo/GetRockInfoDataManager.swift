import Foundation
import Alamofire

class GetRockInfoDataManager{
    func getRockInfo( _ viewController : UIViewController, _ completion: @escaping (_ data : [RockInfoResult]) -> Void){
        var headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json",
                    "x-access-token" : Constant.USER_JWTTOKEN
        ]
        
        AF.request("\(Constant.BASE_URL)/api/rock/manage/\(Constant.USER_ID)", method: .get ,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: RockInfoModel.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        viewController.dismissIndicator()
                        completion(response.result)
                    default:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "알 수 없는 에러가 발생하였습니다.")
                        print("알 수 없는 에러가 발생하였습니다. : 코드번호 \(response.code)")
                    }
                case .failure(let error):
                    print("로그인 실패")
                    print(String(describing: error))
                }

            }
        
    }
}
