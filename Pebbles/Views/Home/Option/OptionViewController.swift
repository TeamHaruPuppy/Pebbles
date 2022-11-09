import UIKit
import SnapKit
import SafariServices

class OptionViewController: UIViewController {
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var termAndConditionBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var signWithdrawalBtn: UIButton!
    
    @IBOutlet weak var termAndConditionLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var signWithdrawalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAttribute()
        self.setConfigure()
        
    }
    
    
    func setConfigure(){
        appBar.snp.makeConstraints{
            $0.top.equalToSuperview().offset(44)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        backBtn.snp.makeConstraints{
            $0.centerY.equalTo(appBar.snp.centerY)
            $0.height.width.equalTo(32)
            $0.left.equalTo(appBar.snp.left).inset(20)
        }
        backImg.snp.makeConstraints{
            $0.centerX.centerY.equalTo(backBtn)
            $0.height.width.equalTo(24)
        }
        titleLabel.snp.makeConstraints{
            $0.centerY.equalTo(appBar.snp.centerY)
            $0.centerX.equalTo(appBar.snp.centerX)
        }
        profileView.snp.makeConstraints{
            $0.top.equalTo(appBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(Constant.edgeHeight*104)
        }
        profileImg.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.height.width.equalTo(64)
        }
        usernameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(profileImg.snp.right).inset(-15)
            
        }
        separateView.snp.makeConstraints{
            $0.top.equalTo(profileView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(Constant.edgeHeight*15)
        }
        termAndConditionBtn.snp.makeConstraints{
            $0.top.equalTo(separateView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        termAndConditionLabel.snp.makeConstraints{
            $0.centerY.equalTo(termAndConditionBtn)
            $0.left.equalToSuperview().inset(20)
        }
        logoutBtn.snp.makeConstraints{
            $0.top.equalTo(termAndConditionBtn.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(36)
        }
        logoutLabel.snp.makeConstraints{
            $0.centerY.equalTo(logoutBtn)
            $0.left.equalToSuperview().inset(20)
        }
        signWithdrawalBtn.snp.makeConstraints{
            $0.top.equalTo(logoutBtn.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(36)
        }
        signWithdrawalLabel.snp.makeConstraints{
            $0.centerY.equalTo(signWithdrawalBtn)
            $0.left.equalToSuperview().inset(20)
        }
    }
    func setAttribute(){
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .White
        profileView.backgroundColor = .White
        titleLabel.textColor = .Gray_60
        separateView.backgroundColor = .Gray_10
        
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderWidth = 0.5
        profileImg.layer.borderColor = UIColor.Gray_30.cgColor
        profileImg.layer.cornerRadius = 32
        
        usernameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        usernameLabel.textColor = .Black
        usernameLabel.text = Constant.USER_NAME
        
        termAndConditionLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termAndConditionLabel.textColor = .Gray_60
        termAndConditionLabel.text = "이용약관"
        logoutLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        logoutLabel.textColor = .alart
        logoutLabel.text = "로그아웃"
        signWithdrawalLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        signWithdrawalLabel.textColor = .Gray_40
        signWithdrawalLabel.text = "회원탈퇴"
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func termAndConditionBtnTapped(_ sender: Any) {
        
        let ctURL = NSURL(string: "https://olivine-shear-610.notion.site/951323d8e4054f1591136dc71e953ef8")
        let safariView: SFSafariViewController = SFSafariViewController(url: ctURL as! URL)
        self.present(safariView, animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        print("로그아웃 누름")
        let vc = LogoutViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func signWithdrawalBtnTapped(_ sender: Any) {
        let vc = SignWithdrawalViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        //
        //
        //        vc.modalPresentationStyle = .overFullScreen
        //        self.present(vc, animated: false)
    }
    
}
