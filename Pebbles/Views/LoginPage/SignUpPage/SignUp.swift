import UIKit
import SnapKit
import Then

class SignUp: UIViewController{
    
    public enum checkBtn {
        case next
        case complete
    }
    
    public enum checkKeyboard{
        case up
        case down
    }
    
    var checkKey = checkKeyboard.down
    var check = checkBtn.next
    
    
    @IBOutlet weak var dissmissBtn: UIButton!
    @IBOutlet weak var nextCompleBtn: UIButton!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: ViewDidLoad() -> View 초기화 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        check = .next
        checkKey = .down
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("-------viewWillAppear이니까 키보드 Notification 추가할게-------")
        self.addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("-------viewWillDisappear이니까 키보드 Notification 제거할게-------")
        self.removeKeyboardNotifications()
    }
    
    
    
    func configure(){
        dissmissBtn.tintColor = .Gray_50
        signUpLabel.tintColor = .Gray_60
        nextCompleBtn.tintColor = .Gray_30
        nextCompleBtn.isEnabled = false
        
        
        
        scrollView.contentSize.width = Device.width
        
        
        btnView.snp.makeConstraints{
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.top.equalToSuperview().offset((Constant.edgeHeight*582))
        }
        
        
        
        for i in 0..<2{
            switch i {
            case 0:
                guard let nicknameView = Bundle.main.loadNibNamed("NicknameView", owner: self)?.first as? NicknameView else {return}
                nicknameView.frame = CGRect(x: 0, y: 0, width: Device.width, height: Device.height - 50)
                nicknameView.delegate = self
                scrollView.addSubview(nicknameView)
                break;
            default:
                guard let goalView = Bundle.main.loadNibNamed("GoalView", owner: self)?.first as? GoalView else {return}
                goalView.frame = CGRect(x: Device.width, y: 0, width: Device.width, height: Device.height - 50)
                scrollView.addSubview(goalView)
                break;
            }
        }
    }
    
    private func checkState(){
        switch check{
        case .next:
            print("-------현재 상태는 next에서 comp로 바뀌는 중-------")
            let compOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
            scrollView.setContentOffset(compOffset, animated: true)
            check = .complete
            DispatchQueue.global(qos: .userInteractive).async {
                DispatchQueue.main.async {
                    self.nextCompleBtn.setTitle("완료", for: .disabled)
                }
            }
            
            
            isNotNextBtnEnabled()
        case .complete:
            print("-------현재 상태는 comp에서 home으로 바뀌는 중-------")
            dismiss(animated: true)
        }
    }
    
    @IBAction func nextCompleBtnTapped(_ sender: Any) {
        checkState()
        self.view.endEditing(true)
        
    }
    
    
    @IBAction func dissmissBtnTapped(_ sender: Any) {
        switch check{
        case .next:
            dismiss(animated: true)
        case .complete:
            scrollView.setContentOffset(.zero, animated: true)
            check = .next
            isNotNextBtnEnabled()
        }
        
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
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
        switch checkKey{
        case .down:
            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                self.btnView.frame.origin.y = Device.height - keyboardHeight - 70
                print("-------키보드가 나타나서 위로 올려줄거야-------")
                print("현재 키보드의 Y값 : \(self.btnView.frame.origin.y)")
            }
            checkKey = .up
        case .up:
            print("-------현재 Keyboard는 올라와있기 때문에 아무 행동 하지 않을거야-------")
        }
        
        print("<현재 checkKey의 값은 : \(checkKey)>")
    }
    
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        switch checkKey{
        case .down:
            print("-------현재 Keyboard는 내려가있기 때문에 아무 행동 하지 않을거야-------")
        case .up:
            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                self.btnView.frame.origin.y = (Constant.edgeHeight*582)
                print("-------키보드가 사라져서 아래로 내려줄거야-------")
                print("현재 키보드의 Y값 : \(self.btnView.frame.origin.y)")
            }
            checkKey = .down
        }
        print("<현재 checkKey의 값은 : \(checkKey)>")
    }
    
    
}

extension SignUp : ChangeBtnDelegate {
    func isNextBtnEnabled(){
        nextCompleBtn.isEnabled = true
        self.nextCompleBtn.tintColor = .Main_30
    }
    
    func isNotNextBtnEnabled() {
        nextCompleBtn.isEnabled = false
        self.nextCompleBtn.tintColor = .Gray_30
    }
}
