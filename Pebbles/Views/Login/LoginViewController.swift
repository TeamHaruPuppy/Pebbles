import UIKit
import SnapKit
import Then
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginViewController: UIViewController {

    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var alreadySignUpLabel: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurate()
    }

    func configurate(){
        startBtn.layer.backgroundColor = UIColor.Main_30.cgColor
        startBtn.layer.masksToBounds = true
        startBtn.layer.cornerRadius = 8
        startBtn.tintColor = .White
        
        alreadySignUpLabel.textColor = .Gray_50
        signUpLabel.textColor = .Gray_50
        
        
        logo.snp.makeConstraints {
            $0.height.width.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(Constant.edgeHeight*210)
        }
        
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).inset(10)
            $0.centerX.equalToSuperview()
        }
        
        startBtn.snp.makeConstraints{
            $0.top.equalTo(signUpLabel.snp.bottom).offset(200)
            //335, 50
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constant.edgeHeight*50)
            $0.width.equalTo(Constant.edgeWidth*335)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(startBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    @IBAction func startBtnTapped(_ sender: Any) {
        //MARK: 임시로 만든 액션
        
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
//        GetHomeDataManager().getHome(self) { data in
//            Constant.homeResult = data
//            Constant.selectDay = data.today
//            let baseTabBarController = HomeViewController()
//            self.changeRootViewController(baseTabBarController)
//        }
    }
}
