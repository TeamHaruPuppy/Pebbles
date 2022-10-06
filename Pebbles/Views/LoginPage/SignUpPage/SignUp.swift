import UIKit
import SnapKit
import Then

class SignUp: UIViewController{
    
    var nickNameView = NicknameView()
    var futureView = UIView()
    
    public enum checkBtn {
        case next
        case complete
    }
    
    var check = checkBtn.next
    
    
    @IBOutlet weak var dissmissBtn: UIButton!
    
    @IBOutlet weak var nextCompleBtn: UIButton!
    @IBOutlet weak var btnView: UIView!
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        check = .next
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.nickNameView.endEditing(true)
    }
    
    func configure(){
        scrollView.contentSize.width = UIScreen.main.bounds.width * 2
        
        for i in 0..<2{
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            
            switch i {
            case 0:
                
                if let nickNameview = Bundle.main.loadNibNamed("NicknameView", owner: nil)?.first as? UIView {
                    
                    nickNameview.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height-appBar.bounds.height)
                    scrollView.addSubview(nickNameview)
                }
                
                break;
            default:
                futureView.frame = CGRect(x: xPosition, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height)
                scrollView.addSubview(futureView)
                break;
            }
        }
    }
    
    private func checkState(){
        switch check{
        case .next:
            print("현재 상태는 next에서 comp로 바뀌는 중")
            let compOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
            scrollView.setContentOffset(compOffset, animated: true)
            check = .complete
        case .complete:
            print("현재 상태는 comp에서 home으로 바뀌는 중")
            dismiss(animated: true)
        }
    }
    
    @IBAction func nextCompleBtnTapped(_ sender: Any) {
        checkState()
    }
    
    
    @IBAction func dissmissBtnTapped(_ sender: Any) {
        switch check{
        case .next:
            dismiss(animated: true)
        case .complete:
            scrollView.setContentOffset(.zero, animated: true)
            check = .next
        }
        
    }
    
    
    
    
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.btnView.frame.origin.y -= (keyboardHeight - 50)
            print("키보드가 나타남")
        }
    }

    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.btnView.frame.origin.y += (keyboardHeight - 50)
        }
    }
    
    
}


