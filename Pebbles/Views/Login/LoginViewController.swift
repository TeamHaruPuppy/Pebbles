import UIKit
import SnapKit
import Then

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
}
