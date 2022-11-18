import SnapKit
import UIKit
import RealmSwift

class SignWithdrawalViewController: UIViewController {
    
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var signWithdrawalBtn: UIButton!
    
    private var checkTxtStart = false
    private var keyBoardUpDown = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .White
        textView.delegate = self
        textView.text = "탈퇴 사유를 적어주세요"
        textView.textColor = .Gray_30
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.Gray_30.cgColor
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.backgroundColor = .White
        
        signWithdrawalBtn.layer.masksToBounds = true
        signWithdrawalBtn.layer.borderWidth = 0
        signWithdrawalBtn.layer.cornerRadius = 10
        
        textView.returnKeyType = .done
        self.setKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func setKeyboardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyBoardUpDown {
                print("업해써")
                signWithdrawalBtn.frame.origin.y -= (keyboardSize.height - 40)
                keyBoardUpDown.toggle()
            }
            print("키보드 높이 : \(keyboardSize.height)")
            print("키보드 y의 원래 위치 : \(signWithdrawalBtn.frame.origin.y)")
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !keyBoardUpDown {
                print("업해써")
                signWithdrawalBtn.frame.origin.y += (keyboardSize.height - 40)
                keyBoardUpDown.toggle()
            }
            print("다운해써")
            print("키보드 y의 원래 위치 : \(signWithdrawalBtn.frame.origin.y)")
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signWithdrawalBtnTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        PostSignWithdrawalDataManager().signWithdrawal(Constant.USER_ID, self) { data in
            Constant.initConstantData()
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            UserDefaults.standard.set(false, forKey: "isAuthLogin")
            UserDefaults.standard.removeObject(forKey: "id")
            UserDefaults.standard.removeObject(forKey: "pwd")
            let rootVC = LoginViewController()
            self.changeRootViewController(rootVC, .curveEaseIn)
        }
    }
    
}


extension SignWithdrawalViewController : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if checkTxtStart == false {
            textView.text = ""
            textView.textColor = .Gray_60
            textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
            checkTxtStart = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != ""{
            signWithdrawalBtn.backgroundColor = .alart
            signWithdrawalBtn.isEnabled = true
        }
        else{
            signWithdrawalBtn.backgroundColor = .Gray_30
            signWithdrawalBtn.isEnabled = false
        }
    }
    
    
}

extension SignWithdrawalViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

