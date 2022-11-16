import UIKit
import SnapKit

class LogoutViewController: UIViewController {
    
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var alterView: UIView!
    @IBOutlet weak var logoutTitleLabel: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.backView.addGestureRecognizer(tapGesture)
        
        self.setConfigure()
        self.setAttribute()
    }
    
    func setConfigure(){
        
    }
    
    func setAttribute(){
        logoutTitleLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        cancleBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        cancleBtn.titleLabel?.tintColor = .Gray_40
        logoutBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        logoutBtn.titleLabel?.tintColor = .alart
        
        separateView.backgroundColor = .Gray_10
        
        alterView.layer.masksToBounds = true
        alterView.layer.borderWidth = 0
        alterView.layer.cornerRadius = 14
        alterView.backgroundColor = .White
        stackView.backgroundColor = .White
        
        backView.alpha = 0.3
    }
    
    @IBAction func cancleBtnTapped(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pwd")
        UserDefaults.standard.set(false, forKey: "isAuthLogin")
        Constant.USER_ID = 0
        Constant.USER_JWTTOKEN = ""
        self.dismiss(animated: false)
        let rootVC = LoginViewController()
        changeRootViewController(rootVC, .overrideInheritedDuration)
    }
    
}

extension LogoutViewController : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        self.dismiss(animated: false)
        return true
    }
}
