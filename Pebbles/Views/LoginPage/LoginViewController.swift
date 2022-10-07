import UIKit
import SnapKit
import Then
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!

    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var appleBtn: UIImageView!
    @IBOutlet weak var kakaoBtn: UIImageView!
    @IBOutlet weak var naverBtn: UIImageView!
    
    @IBOutlet weak var btn_apple_action: UIButton!
    @IBOutlet weak var btn_kakao_action: UIButton!
    @IBOutlet weak var btn_naver_action: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurate()
    }

    func configurate(){
        appleBtn.contentMode = .scaleAspectFit
        kakaoBtn.contentMode = .scaleAspectFit
        naverBtn.contentMode = .scaleAspectFit
        
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constant.edgeHeight*175)
            $0.bottom.equalToSuperview().offset(-Constant.edgeHeight*350)
            $0.left.equalToSuperview().offset(Constant.edgeWidth*44)
            $0.right.equalToSuperview().offset(-Constant.edgeWidth*44)
        }
        
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(-Constant.edgeHeight*51)
        }
        
        appleBtn.snp.makeConstraints{
            $0.top.equalTo(signUpLabel.snp.bottom).offset(Constant.edgeHeight*35)
            $0.height.equalTo(50)
            $0.width.equalTo(335)
            $0.centerX.equalToSuperview()
//            $0.left.equalToSuperview().offset(20)
//            $0.right.equalToSuperview().offset(-20)
        }
        kakaoBtn.snp.makeConstraints{
            $0.top.equalTo(appleBtn.snp.bottom).offset(Constant.edgeHeight*10)
            
            $0.height.equalTo(50)
            $0.width.equalTo(335)
            $0.centerX.equalToSuperview()
//            $0.left.equalToSuperview().offset(20)
//            $0.right.equalToSuperview().offset(-20)
        }
        naverBtn.snp.makeConstraints{
            $0.top.equalTo(kakaoBtn.snp.bottom).offset(Constant.edgeHeight*10)
            
            $0.height.equalTo(50)
            $0.width.equalTo(335)
            $0.centerX.equalToSuperview()
//            $0.left.equalToSuperview().offset(20)
//            $0.right.equalToSuperview().offset(-20)
        }
        
        btn_apple_action.snp.makeConstraints{
            $0.edges.equalTo(appleBtn).inset(-4)
        }
        btn_kakao_action.snp.makeConstraints{
            $0.edges.equalTo(kakaoBtn).inset(-4)
        }
        btn_naver_action.snp.makeConstraints{
            $0.edges.equalTo(naverBtn).inset(-4)
        }
    }
    
    @IBAction func kakaoBtnTapped(_ sender: Any) {
        
        // 원래는 kakaoAPI호출해서 토큰 받아오는 작업 필요
        let signUpViewController = SignUp(nibName: "SignUp", bundle: nil)
        signUpViewController.modalTransitionStyle = .coverVertical
        signUpViewController.modalPresentationStyle = .overFullScreen
        self.present(signUpViewController, animated: true, completion: nil)
        
        print("-------카카오 로그인을 눌렀네??-------")
        
        //        // 카카오톡 설치 여부 확인
        //        if (UserApi.isKakaoTalkLoginAvailable()) {
        //            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
        //            loginWithApp()
        //        }
        //        else{
        //            // 만약, 카카오톡이 깔려있지 않을 경우에는 웹 브라우저로 카카오 로그인함.
        //             loginWithWeb()
        //        }
                
    }
    
    
    
//    func loginWithApp() {
//        UserApi.shared.loginWithKakaoTalk {(_, error) in
//            if let error = error {
//                print(error)
//            } else {
//                print("loginWithKakaoTalk() success.")
//
//                UserApi.shared.me {(user, error) in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        guard let nickname = user?.kakaoAccount?.profile?.nickname, let email = user?.kakaoAccount?.email else {return;}
//                        // 받아온 닉네임과 이메일을 DB에 보내주고, Local에도 저장(?)하는 과정 필요함
//
//                        self.presentToMain()
//
//                    }
//                }
//            }
//        }
//    }
    
    
    // 카카오톡 웹으로 로그인
//    func loginWithWeb() {
//        UserApi.shared.loginWithKakaoAccount {(_, error) in
//            if let error = error {
//                print(error)
//            } else {
//                print("loginWithKakaoAccount() success.")
//
//                UserApi.shared.me {(user, error) in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        guard let nickname = user?.kakaoAccount?.profile?.nickname, let email = user?.kakaoAccount?.email else {return;}
//
//                        self.presentToMain()
//                    }
//                }
//            }
//        }
//    }
    
//    func presentToMain() {
//        //MARK: base로 설정한 Tabbar를 설정하고, RootView로 재설정 한다.
//        let baseTabBarController = BaseTabBarViewController()
//        self.changeRootViewController(baseTabBarController)
//
//    }
}
