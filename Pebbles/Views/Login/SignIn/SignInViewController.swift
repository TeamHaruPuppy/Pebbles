import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var appBarTitleLabel: UILabel!
    @IBOutlet weak var backBtnImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorMessageLabel: UILabel!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var upSeperateView: UIView!
    @IBOutlet weak var findPasswordIntroLabel: UILabel!
    @IBOutlet weak var downSeperateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAttribute()
        self.setConfigure()
        
        if UserDefaults.standard.bool(forKey: "isAuthLogin"){
            print("여기 들어오냐?")
            login(UserDefaults.standard.string(forKey: "id"), UserDefaults.standard.string(forKey: "pwd"))
        }
        
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setAttribute(){
        self.view.backgroundColor = .White
        backBtnImg.tintColor = .Gray_50
        appBarTitleLabel.textColor = .Gray_60
        
        idTextField.returnKeyType = .done
        passwordTextField.returnKeyType = .done
        
        idTextField.placeholder = "아이디(닉네임)"
        idTextField.setPlaceholderColor(.Gray_30)
        idTextField.layer.borderColor = UIColor.Gray_30.cgColor
        idTextField.textColor = .Gray_60
        idTextField.backgroundColor = .White
        idTextField.layer.borderWidth = 1
        idTextField.layer.cornerRadius = 10
        
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.setPlaceholderColor(.Gray_30)
        passwordTextField.layer.borderColor = UIColor.Gray_30.cgColor
        passwordTextField.textColor = .Gray_60
        passwordTextField.backgroundColor = .White
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 10
        passwordErrorMessageLabel.text = ""
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        
        signInBtn.layer.masksToBounds = true
        signInBtn.layer.cornerRadius = 10
        signInBtn.layer.backgroundColor = UIColor.Gray_30.cgColor
        signInBtn.isSelected = false
        signInBtn.isEnabled = false
        
        upSeperateView.backgroundColor = .Gray_20
        downSeperateView.backgroundColor = .Gray_20
        
        findPasswordIntroLabel.textColor = .Gray_30
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
            $0.left.equalTo(appBar.snp.left).inset(20)
        }
        appBarTitleLabel.snp.makeConstraints{
            $0.centerY.equalTo(appBar.snp.centerY)
            $0.centerX.equalTo(appBar.snp.centerX)
        }
        backBtnImg.snp.makeConstraints{
            $0.centerX.centerY.equalTo(backBtn)
            $0.height.width.equalTo(20)
        }
        idTextField.snp.makeConstraints{
            $0.top.equalTo(appBar.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints{
            $0.top.equalTo(idTextField.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        passwordErrorMessageLabel.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(20)
        }
        signInBtn.snp.makeConstraints{
            $0.top.equalTo(passwordErrorMessageLabel.snp.bottom).offset(30)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        upSeperateView.snp.makeConstraints{
            $0.top.equalTo(signInBtn.snp.bottom).offset(30)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        findPasswordIntroLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(upSeperateView.snp.bottom).offset(12)
        }
        downSeperateView.snp.makeConstraints{
            $0.top.equalTo(findPasswordIntroLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    func getHome(){
        GetHomeDataManager().getHome(self) { data in
            Constant.homeResult = data
            Constant.selectDay = Date().onlyWeek
            print("홈으로 가기 전 uid는? : \(Constant.USER_ID)")
            print("홈으로 가기 전 JWT는? : \(Constant.USER_JWTTOKEN)")
            print("홈 데이터 전부 보여줘 : \(Constant.homeResult)")
            
        }
    }
    
    func getRockData(){
        GetRockInfoDataManager().getRockInfo(self) { data in
            Constant.rockResult = data
            let rootVC = BaseTabBarViewController()
            rootVC.modalPresentationStyle = .fullScreen
            self.present(rootVC, animated: false)
        }
    }
    
    func login(_ username : String?, _ password : String?){
        guard let username = username else {return;}
        guard let password = password else {return;}
        self.showIndicator()
        SignInDataManager().signIn(username, password, self) { data in
            if data.isSuccess == true{
                guard let data = data.result else {return;}
                Constant.USER_JWTTOKEN = data.jwt
                Constant.USER_ID = data.userID
                Constant.USER_NAME = username
                UserDefaults.standard.set(username, forKey: "id")
                UserDefaults.standard.set(password, forKey: "pwd")
                UserDefaults.standard.set(true, forKey: "isAuthLogin")
                self.showIndicator()
                self.getHome()
                self.getRockData()
            }else {
                self.idTextField.layer.borderColor = UIColor.alart.cgColor
                self.passwordTextField.layer.borderColor = UIColor.alart.cgColor
                self.passwordErrorMessageLabel.textColor = .alart
                self.passwordErrorMessageLabel.text = data.message
                
                self.signInBtn.isEnabled.toggle()
                self.signInBtn.backgroundColor = .Gray_30
            }
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        self.login(idTextField.text, passwordTextField.text)
    }
}


extension SignInViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1{
            textField.text = ""
            idTextField.layer.borderColor = UIColor.Gray_30.cgColor
            passwordTextField.layer.borderColor = UIColor.Gray_30.cgColor
            idTextField.text = ""
            
        }
        else{
            textField.text = ""
            
            idTextField.layer.borderColor = UIColor.Gray_30.cgColor
            passwordTextField.layer.borderColor = UIColor.Gray_30.cgColor
            passwordErrorMessageLabel.text = ""
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let id = idTextField.text else {return;}
        guard let password = passwordTextField.text else {return;}
        
        if id.isEmpty == false && password.isEmpty == false {
            self.signInBtn.isEnabled.toggle()
            self.signInBtn.backgroundColor = .Main_30
        }
        
    }
}

extension SignInViewController : UIScrollViewDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}


