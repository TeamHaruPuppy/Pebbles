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
        if UserDefaults.standard.bool(forKey: "isFirstRun") == false{
            let vc = OnboardingViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            UserDefaults.standard.set(true, forKey: "isFirstRun")
        }
        else{
            let viewController = UINavigationController(rootViewController: FirstSignUpViewController())
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        let vc = SignInViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
