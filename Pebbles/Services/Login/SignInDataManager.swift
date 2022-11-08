import Foundation
import Alamofire

class SignInDataManager{
    func signIn(_ username : String, _ password : String, _ viewController : UIViewController, completion: @escaping (_ data: SignInModel) -> Void){
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json"
        ]
        let js = "{\"password\":\"\(password)\",\"username\":\"\(username)\"}"
        let parameters: Parameters = ["jsonRequest": "\(js)"]
        
        let param : Parameters = [
            "password": "\(password)",
            "username": "\(username)"
        ]
        
        AF.request("\(Constant.BASE_URL)/api/login", method: .post, parameters: param ,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: SignInModel.self){response in
                switch response.result {
                case .success(let response):
                    print("로그인 안으로 들어왔냐? : \(response)")
                    switch response.code{
                    case 1000:
                        viewController.dismissIndicator()
                        completion(response)
                    case 3014:
                        viewController.dismissIndicator()
                        completion(response)
                    default:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "알 수 없는 에러가 발생하였습니다.")
                        print("알 수 없는 에러가 발생하였습니다. : 코드번호 \(response.code)")
                    }
                case .failure(let error):
                    print("로그인 실패")
                    debugPrint(error)
                }
                
            }
        
    }
}
