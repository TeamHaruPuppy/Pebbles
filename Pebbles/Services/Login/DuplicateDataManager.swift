import Foundation
import Alamofire


//MARK: - 쿼리스트링으로 데이터 넘길 때는 encoding: URLEncoding(destination: .queryString) 사용하기
class DuplicateDataManager{
    func duplicateNickname(_ username : String, _ viewController : UIViewController, completion: @escaping (_ data: DuplicateModel) -> Void){
        var headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json"
        ]
        
        var param : Parameters = [
            "username" : "\(username)"
        ]
        AF.request("\(Constant.BASE_URL)/api/duplicate/username", method: .post , parameters: param ,encoding: URLEncoding(destination: .queryString), headers: headers)
            .responseDecodable(of: DuplicateModel.self){response in
                switch response.result {
                case .success(let response):
                    print("성공")
                    switch response.code{
                    case 1000:
                        completion(response)
                        viewController.dismissIndicator()
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
                    print("로그인 실패")
                    debugPrint(error)
                }
                
            }
        
    }
}
