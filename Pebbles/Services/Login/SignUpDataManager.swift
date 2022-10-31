import Foundation
import Alamofire

class SignUpDataManager{
    func signUp(_ username : String, _ password : String ,_ goal : String, _ viewController : UIViewController, completion: @escaping (_ data: SignUpResult) -> Void){
        let headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json"
        ]
        let param : Parameters = [
                "goal" : "\(goal)",
                "password" : "\(password)",
                "username" : "\(username)",
                
        ]
        
        AF.request("\(Constant.BASE_URL)/auth/join", method: .post, parameters: param ,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: SignUpModel.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        completion(response.result)
                    case 2103:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "계정 아이디를 입력해주세요")
                        print("계정 아이디를 입력해주세요")
                    case 2104:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "계정 아이디는 20자리 미만으로 입력해주세요.")
                        print("계정 아이디는 20자리 미만으로 입력해주세요.")
                    case 2106:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "비밀번호를 입력 해주세요.")
                        print("비밀번호를 입력 해주세요.")
                    case 2107:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "비밀번호는 20자리 미만으로 입력해주세요.")
                        print("비밀번호는 20자리 미만으로 입력해주세요.")
                    case 2111:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "생일을 올바르게 입력 해주세요.")
                        print("생일을 올바르게 입력 해주세요.")
                    case 2112:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "번호를 입력 해주세요.")
                        print("번호를 입력 해주세요.")
                    case 2113:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "번호를 11자리 미만으로 입력해주세요.")
                        print("번호를 11자리 미만으로 입력해주세요.")
                    case 2114:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "핸드폰 번호를 숫자만으로 입력해주세요.")
                        print("핸드폰 번호를 숫자만으로 입력해주세요.")
                    case 2115:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "아이디를 숫자와 영문으로만 입력해주세요.")
                        print("아이디를 숫자와 영문으로만 입력해주세요.")
                    case 2116:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "실명을 입력 해주세요.")
                        print("실명을 입력 해주세요.")
                    case 2117:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "실명을 20자 미만으로 입력해주세요.")
                        print("실명을 20자 미만으로 입력해주세요.")
                    case 2230:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "중복된 아이디입니다.")
                        print("중복된 아이디입니다.")
                    case 2232:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "아이디가 잘못 되었습니다.")
                        print("아이디가 잘못 되었습니다.")
                    case 2233:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "비밀번호가 잘못 되었습니다.")
                        print("비밀번호가 잘못 되었습니다.")
                    case 4000:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "데이터 베이스 커넥션 에러")
                        print("데이터 베이스 커넥션 에러")
                    case 4001:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "서버 에러")
                        print("서버 에러")
                    case 4002:
                        viewController.dismissIndicator()
                        viewController.presentAlert(title: "데이터 베이스 쿼리 에러")
                        print("데이터 베이스 쿼리 에러")
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
        
    }
}
