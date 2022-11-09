import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController{
    
    
    enum nicknameError {
        case sevenChar
        case specialChar
        case dupNickname
        case validName
    }
    enum passwordError {
        case shortOrLongPassword
        case noEng
        case noNum
        case noSpecial
        case allIn
        case validPassword
    }
    
    enum rePasswordError {
        case unCorrect
        case validRePassword
    }
    
    // T : 글자 수 에러 & F : 정규화 에러
    var isNicknameError : [nicknameError] = []
    var isPasswordError : [passwordError] = []
    var isRePasswordError : [rePasswordError] = []
    var keyBoardUpDown = false
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var backBtnImg: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var dupVerificationLabel: UILabel!
    @IBOutlet weak var dupVerificationBtn: UIButton!
    @IBOutlet weak var nicknameErrorMessage: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorMessage: UILabel!
    @IBOutlet weak var rePasswordLabel: UILabel!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var rePasswordErrorMessage: UILabel!
    
    @IBOutlet weak var compleBtn: UIButton!
    
    
    //MARK: ViewDidLoad() -> View 초기화 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstants()
        self.setAttribute()
        self.setTextFieldSync()
        self.setKeyboardObserver()
        
        
        nicknameTextField.delegate = self
        passwordTextField.delegate = self
        rePasswordTextField.delegate = self
        
        nicknameTextField.tag = 1
        passwordTextField.tag = 2
        rePasswordTextField.tag = 3
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        nicknameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        rePasswordTextField.resignFirstResponder()
    }
    
    func setAttribute(){
        backBtnImg.tintColor = .Gray_50
        signUpLabel.textColor = .Gray_60
        introLabel.textColor = .Gray_60
        
        nicknameTextField.returnKeyType = .done
        passwordTextField.returnKeyType = .done
        rePasswordTextField.returnKeyType = .done
        
        nicknameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        nicknameLabel.textColor = .Gray_50
        nicknameTextField.placeholder = "설정된 닉네임은 수정이 불가해요."
        nicknameTextField.setPlaceholderColor(.Gray_30)
        nicknameTextField.layer.borderColor = UIColor.Gray_30.cgColor
        nicknameTextField.textColor = .Gray_60
        nicknameTextField.backgroundColor = .White
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.cornerRadius = 10
        dupVerificationLabel.textColor = .Gray_30
        dupVerificationBtn.isEnabled = false
        dupVerificationBtn.backgroundColor = .clear
        nicknameErrorMessage.text = ""
        
        passwordLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        passwordLabel.textColor = .Gray_50
        passwordTextField.placeholder = "비밀번호를 입력해주세요."
        passwordTextField.setPlaceholderColor(.Gray_30)
        passwordTextField.layer.borderColor = UIColor.Gray_30.cgColor
        passwordTextField.textColor = .Gray_60
        passwordTextField.backgroundColor = .White
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 10
        passwordErrorMessage.text = ""
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        
        rePasswordLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        rePasswordLabel.textColor = .Gray_50
        rePasswordTextField.placeholder = "비밀번호를 한번 더 입력해주세요."
        rePasswordTextField.setPlaceholderColor(.Gray_30)
        rePasswordTextField.layer.borderColor = UIColor.Gray_30.cgColor
        rePasswordTextField.textColor = .Gray_60
        rePasswordTextField.backgroundColor = .White
        rePasswordTextField.layer.borderWidth = 1
        rePasswordTextField.layer.cornerRadius = 10
        rePasswordErrorMessage.text = ""
        rePasswordTextField.isSecureTextEntry = true
        rePasswordTextField.textContentType = .password
        
        compleBtn.layer.masksToBounds = true
        compleBtn.layer.cornerRadius = 10
        compleBtn.layer.backgroundColor = UIColor.Gray_30.cgColor
        compleBtn.isSelected = false
        compleBtn.isEnabled = false
    }
    
    func setKeyboardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setConstants(){
        
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
        backBtnImg.snp.makeConstraints{
            $0.centerX.centerY.equalTo(backBtn)
            $0.height.width.equalTo(20)
        }
        signUpLabel.snp.makeConstraints{
            $0.centerY.equalTo(appBar.snp.centerY)
            $0.centerX.equalTo(appBar.snp.centerX)
        }
        
        scrollView.snp.makeConstraints{
            $0.top.equalTo(appBar.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
        
        introLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.left.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints{
            $0.top.equalTo(introLabel.snp.bottom).offset(25)
            $0.left.equalToSuperview()
        }
        
        nicknameTextField.snp.makeConstraints{
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.width.equalTo(Device.width-40)
            $0.height.equalTo(50)
        }
        dupVerificationBtn.snp.makeConstraints{
            $0.top.equalTo(nicknameTextField.snp.top)
            $0.bottom.equalTo(nicknameTextField.snp.bottom)
            $0.right.equalTo(nicknameTextField.snp.right)
            $0.width.equalTo(60)
        }
        dupVerificationLabel.snp.makeConstraints{
            $0.centerY.equalTo(dupVerificationBtn.snp.centerY)
            $0.centerX.equalTo(dupVerificationBtn.snp.centerX)
        }
        nicknameErrorMessage.snp.makeConstraints{
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            $0.left.equalToSuperview()
        }
        
        passwordLabel.snp.makeConstraints{
            $0.top.equalTo(nicknameErrorMessage.snp.bottom).offset(45)
            $0.left.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints{
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.width.equalTo(Device.width-40)
            $0.height.equalTo(50)
        }
        passwordErrorMessage.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
            $0.left.equalToSuperview()
        }
        
        rePasswordLabel.snp.makeConstraints{
            $0.top.equalTo(passwordErrorMessage.snp.bottom).offset(30)
            $0.left.equalToSuperview()
        }
        
        rePasswordTextField.snp.makeConstraints{
            $0.top.equalTo(rePasswordLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.width.equalTo(Device.width-40)
            $0.height.equalTo(50)
        }
        rePasswordErrorMessage.snp.makeConstraints{
            $0.top.equalTo(rePasswordTextField.snp.bottom).offset(8)
            $0.left.equalToSuperview()
        }
        
        compleBtn.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.width.equalTo(Device.width-40)
            $0.height.equalTo(50)
            $0.top.equalTo(rePasswordErrorMessage.snp.bottom).offset(100)
        }
        
       
    }
    
    
    func setTextFieldSync(){
        self.nicknameTextField.addTarget(self, action: #selector(self.nicknameTextFieldDidChange(_ :)), for: .allEditingEvents)
        self.passwordTextField.addTarget(self, action: #selector(self.passwordTextFieldDidChange(_ :)), for: .allEditingEvents)
                self.rePasswordTextField.addTarget(self, action: #selector(self.rePasswordTextFieldDidChange(_ :)), for: .allEditingEvents)
    }
    
    @objc func rePasswordTextFieldDidChange(_ sender : Any) -> Void{
        guard let rePassword = rePasswordTextField.text else {return}
        
        if rePassword.count == 0 {
            rePasswordTextField.layer.borderColor = UIColor.Gray_30.cgColor
            rePasswordErrorMessage.textColor = .Gray_60
            rePasswordErrorMessage.text = ""
            return;
        }
        
        switch isRePasswordError.last{
        case .unCorrect :
            self.rePasswordErrorMessage.textColor = .alart
            self.rePasswordErrorMessage.text = "비밀번호가 일치하지 않습니다."
            self.rePasswordTextField.layer.borderColor = UIColor.alart.cgColor
            break;
        default:
            self.rePasswordErrorMessage.textColor = .Main_30
            self.rePasswordErrorMessage.text = "비밀번호가 일치합니다."
            self.rePasswordTextField.layer.borderColor = UIColor.Main_30.cgColor
            self.isRePasswordError.popLast()
            self.isRePasswordError.append(.validRePassword)
            break;
        }
    }
    
    @objc func passwordTextFieldDidChange(_ sender : Any) -> Void{
        guard let password = passwordTextField.text else {return}
        
        //MARK: - 비밀번호 입력 없을 때
        if password.count == 0 {
            passwordTextField.layer.borderColor = UIColor.Gray_30.cgColor
            passwordErrorMessage.textColor = .Gray_60
            passwordErrorMessage.text = ""
            return;
        }
        
        switch isPasswordError.last{
        case .shortOrLongPassword:
            self.passwordErrorMessage.textColor = .alart
            self.passwordErrorMessage.text = "비밀번호는 8글자 이상이어야 합니다."
            self.passwordTextField.layer.borderColor = UIColor.alart.cgColor
            break;
        case .noSpecial:
            self.passwordErrorMessage.textColor = .alart
            self.passwordErrorMessage.text = "적어도 하나의 특수문자,영문,숫자를 포함해야합니다."
            self.passwordTextField.layer.borderColor = UIColor.alart.cgColor
            break;
        case .noEng:
            self.passwordErrorMessage.textColor = .alart
            self.passwordErrorMessage.text = "적어도 하나의 특수문자,영문,숫자를 포함해야합니다."
            self.passwordTextField.layer.borderColor = UIColor.alart.cgColor
            break;
        case .noNum:
            self.passwordErrorMessage.textColor = .alart
            self.passwordErrorMessage.text = "적어도 하나의 특수문자,영문,숫자를 포함해야합니다."
            self.passwordTextField.layer.borderColor = UIColor.alart.cgColor
            break;
        default:
            self.passwordErrorMessage.textColor = .Main_30
            self.passwordErrorMessage.text = "사용가능한 비밀번호 입니다."
            self.passwordTextField.layer.borderColor = UIColor.Main_30.cgColor
            self.isPasswordError.popLast()
            self.isPasswordError.append(.validPassword)
            break;
        }
        
       //MARK: - 8글자 미만일 때
        if isPasswordError.last == .shortOrLongPassword{
            
        }
        //MARK: - 비밀번호 정규식을 모두 만족할 때
        if isPasswordError.last == .allIn{
            
            return;
        }
        
    }
    
    
    @objc func nicknameTextFieldDidChange(_ sender : Any){
        guard let nickname = nicknameTextField.text else {return}
        
        //MARK: - 닉네임 오류가 없을 때
        if isNicknameError.count == 0 {
            if(nickname.count > 7 || nickname.count == 0){
                nicknameTextField.layer.borderColor = UIColor.Gray_30.cgColor
                nicknameErrorMessage.textColor = .Gray_60
                nicknameErrorMessage.text = ""
                dupVerificationBtn.isEnabled = false
                dupVerificationLabel.textColor = .Gray_30
            }
            else {
                nicknameTextField.layer.borderColor = UIColor.Main_30.cgColor
                nicknameErrorMessage.textColor = .Gray_60
                nicknameErrorMessage.text = ""
                dupVerificationBtn.isEnabled = true
                dupVerificationLabel.textColor = .Main_30
            }
        }
        //MARK: - 닉네임 오류가 있을 때
        else{
            if isNicknameError.last == .sevenChar{
                nicknameErrorMessage.textColor = .alart
                nicknameErrorMessage.text = "닉네임은 7자를 초과할 수 없습니다."
                isNicknameError.removeLast()
            }
            if isNicknameError.last == .specialChar{
                nicknameErrorMessage.textColor = .alart
                nicknameErrorMessage.text = "특수문자나 이모티콘은 입력할 수 없습니다."
            }
            nicknameTextField.layer.borderColor = UIColor.alart.cgColor
            dupVerificationBtn.isEnabled = false
            dupVerificationLabel.textColor = .Gray_30
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("키보드 높이 : \(keyboardSize.height)")
            if !keyBoardUpDown {
                return
            }
            if self.view.frame.origin.y == 0 {
                self.scrollView.contentOffset.y += keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.scrollView.contentOffset.y != 0 {
            self.scrollView.contentOffset.y = 0
            keyBoardUpDown = false
        }
    }
    
    @IBAction func dupBtnTapped(_ sender: Any) {
        self.showIndicator()
        guard let username = nicknameTextField.text else {return;}
        DuplicateDataManager().duplicateNickname(username, self) { data in
            self.dupVerificationBtn.isEnabled.toggle()
            if data.result == true {
                self.nicknameErrorMessage.textColor = .Gray_60
                self.dupVerificationBtn.isEnabled = false
                self.dupVerificationLabel.textColor = .Gray_30
                self.nicknameErrorMessage.textColor = .alart
                self.nicknameErrorMessage.text = "닉네임이 중복되었습니다."
                self.nicknameTextField.layer.borderColor = UIColor.Gray_30.cgColor
                self.isNicknameError.append(.dupNickname)
            }
            else{
                self.nicknameErrorMessage.textColor = .Gray_60
                self.dupVerificationBtn.isEnabled = false
                self.dupVerificationLabel.textColor = .Gray_30
                self.nicknameErrorMessage.textColor = .Main_30
                self.nicknameErrorMessage.text = "사용가능한 닉네임 입니다."
                self.nicknameTextField.layer.borderColor = UIColor.Main_30.cgColor
                self.isNicknameError.append(.validName)
            }
        }
    }
    @IBAction func compleBtnTapped(_ sender: Any) {
        guard let username = nicknameTextField.text else {return;}
        guard let password = rePasswordTextField.text else {return;}
            
        SignUpDataManager().signUp(username, password, "", self) { data in
            Constant.USER_ID = data.userID
            Constant.USER_JWTTOKEN = data.jwt
            Constant.USER_NAME = username
            GetHomeDataManager().getHome(self) { data in
                Constant.homeResult = data
                print("홈으로 가기 전 uid는? : \(Constant.USER_ID)")
                print("홈으로 가기 전 JWT는? : \(Constant.USER_JWTTOKEN)")
                print("홈 데이터 전부 보여줘 : \(Constant.homeResult)")
                self.dismiss(animated: true)
                let baseViewController = HomeViewController()
                self.changeRootViewController(baseViewController, .transitionCrossDissolve)
            }
        }
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            if isNicknameError.last == .validName
                && isPasswordError.last == .validPassword
                && isRePasswordError.last == .validRePassword{
                self.compleBtn.isEnabled.toggle()
                self.compleBtn.backgroundColor = .Main_30
            }
        }
        if textField.tag == 2 {
            if isNicknameError.last == .validName
                && isPasswordError.last == .validPassword
                && isRePasswordError.last == .validRePassword{
                self.compleBtn.isEnabled.toggle()
                self.compleBtn.backgroundColor = .Main_30
            }
        }
        if textField.tag == 3 {
            if isNicknameError.last == .validName
                && isPasswordError.last == .validPassword
                && isRePasswordError.last == .validRePassword{
                self.compleBtn.isEnabled.toggle()
                self.compleBtn.backgroundColor = .Main_30
            }
        }
    }
    
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            isNicknameError.removeAll()
            textField.text = ""
        }
        if textField.tag == 2{
            isPasswordError.removeAll()
        }
        if textField.tag == 3{
            self.keyBoardUpDown = true
            isRePasswordError.removeAll()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        
        if textField.tag == 3{
            let input = NSString(string: textField.text ?? "")
            let rePassword = input.replacingCharacters(in: range, with: string)
            
            if isBackSpace == -92{
                if isRePasswordError.count > 0{
                    isRePasswordError.removeLast()
                    print("에러배열 하나 지움. 현재 에러배열 크기 :\(isRePasswordError.count)")
                    print("마지막 에러 종류는: \(String(describing: isRePasswordError.last))")
                }
                return true
            }
            
            if rePassword == passwordTextField.text{
                print("마지막 에러 종류는: \(String(describing: isRePasswordError.last))")
                isRePasswordError.append(.validRePassword)
                return true
            }
            else{
                print("마지막 에러 종류는: \(String(describing: isRePasswordError.last))")
                isRePasswordError.append(.unCorrect)
                return true
            }
        }
        
        if textField.tag == 2{
            let input = NSString(string: textField.text ?? "")
            let password = input.replacingCharacters(in: range, with: string)
            
            let numPattern = "(?=.*[0-9])"
            let alphaPattern = "(?=.*[a-zA-Z])"
            let specialPattern = "(?=.*[~!@#\\$%\\^&\\*])"
            
            if isBackSpace == -92{
                if isPasswordError.count > 0{
                    isPasswordError.removeLast()
                    print("에러배열 하나 지움. 현재 에러배열 크기 :\(isPasswordError.count)")
                    print("마지막 에러 종류는: \(String(describing: isPasswordError.last))")
                }
                return true
            }
            if password.count < 8{
                isPasswordError.append(.shortOrLongPassword)
                print("8글자 미만임. 현재 에러배열 크기 :\(isPasswordError.count)")
                print("패스워드 글자 수 : \(password.count)")
                print("마지막 에러 종류는: \(String(describing: isPasswordError.last))")
                return true
            }
            
            guard let checkNum = password.range(of: numPattern, options: .regularExpression) else {
                isPasswordError.append(.noNum)
                print("숫자 미포함임. 현재 에러배열 크기 :\(isPasswordError.count)")
                print("마지막 에러 종류는: \(String(describing: isPasswordError.last))")
                return true
            }
            guard let checkAlpha = password.range(of: alphaPattern, options: .regularExpression) else {
                isPasswordError.append(.noEng)
                print("영문 미포함임. 현재 에러배열 크기 :\(isPasswordError.count)")
                print("마지막 에러 종류는: \(String(describing: isPasswordError.last))")
                return true
            }
            guard let checkSpecial = password.range(of: specialPattern, options: .regularExpression) else {
                isPasswordError.append(.noSpecial)
                print("특수문자 미포함임. 현재 에러배열 크기 :\(isPasswordError.count)")
                print("마지막 에러 종류는: \(String(describing: isPasswordError.last))")
                return true
            }
            isPasswordError.append(.allIn)
            print("모든 조건 충족. 현재 에러배열 크기 :\(isPasswordError.count)")
            print("마지막 에러 종류는: \(String(describing: isPasswordError.last))")
            return true
            
        }
        
        if textField.tag == 1 {
            if isBackSpace == -92{
                if isNicknameError.count > 0{
                    isNicknameError.removeLast()
                    print("에러배열 하나 지움. 현재 에러배열 크기 :\(isNicknameError.count)")
                    print("마지막 에러 종류는: \(isNicknameError.last)")
                }
                return true
            }
            
            if !string.hasCharacters(){
                let nickname = textField.text ?? ""
                if nickname.count >= 7 {
                    let index = nickname.index(nickname.startIndex, offsetBy: 6)
                    let newString = nickname[nickname.startIndex..<index]
                    textField.text = String(newString)
                    isNicknameError.append(.sevenChar)
                    return true
                }
                isNicknameError.append(.specialChar)
                print("특수문자 집어넣음. 현재 에러배열 크기 : \(isNicknameError.count)")
                print("마지막 에러 종류는: \(isNicknameError.last)")
            }else{
                let nickname = textField.text ?? ""
                if nickname.count >= 7 {
                    let index = nickname.index(nickname.startIndex, offsetBy: 6)
                    let newString = nickname[nickname.startIndex..<index]
                    textField.text = String(newString)
                    isNicknameError.append(.sevenChar)
                }
                
                print("7글자 이상임. 현재 에러배열 크기 : \(isNicknameError.count)")
                print("마지막 에러 종류는: \(isNicknameError.last)")
            }
            return true
        }
        else{
            return true
        }
    }
}

extension SignUpViewController : UIScrollViewDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}


