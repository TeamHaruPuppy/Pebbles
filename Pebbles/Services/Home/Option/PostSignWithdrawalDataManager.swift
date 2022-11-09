import Foundation
import Alamofire

class PostSignWithdrawalDataManager{
    func signWithdrawal(_ userId : Int, _ viewController : UIViewController, completion: @escaping (_ data: SignWithdrawalModel) -> Void){
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json",
            "X-ACCESS-TOKEN" : Constant.USER_JWTTOKEN
        ]
        
        AF.request("\(Constant.BASE_URL)/api/user/\(userId)/out", method: .post, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: SignWithdrawalModel.self){response in
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
                    print("회원탈퇴 실패")
                    debugPrint(error)
                }
                
            }
        
    }
}
