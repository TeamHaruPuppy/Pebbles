import Foundation
import Alamofire
import SwiftyJSON

class PostHighlightDataManager{
    func postHighlight( _ postHighlightData : HighlightPostModel, _ viewController : UIViewController, completion: @escaping (_ data: PostHighlightResResult) -> Void){
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json",
            "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        
        do {
            let data = try JSONEncoder().encode(postHighlightData)
            let param = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            
            AF.request("\(Constant.BASE_URL)/api/rock/manage/new/\(Constant.USER_ID)", method: .post, parameters: param ,encoding: JSONEncoding.default, headers: headers)
                .responseDecodable(of: PostHighlightRes.self){response in
                    print("실패전에 머라고 뜨니?")
                    switch response.result {
                    case .success(let response):
                        print("성공")
                        switch response.code{
                        case 1000:
                            print(response)
                            completion(response.result)
                        default:
                            viewController.dismissIndicator()
                            viewController.presentAlert(title: "알 수 없는 에러가 발생하였습니다.")
                            print("알 수 없는 에러가 발생하였습니다. : 코드번호 \(response.code)")
                        }
                    case .failure(let error):
                        print("회원가입 실패")
                        debugPrint(error)
                    }
                    
                }
        }catch {
            print(error)
        }
    }
}
