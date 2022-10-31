import UIKit
import SnapKit
import Then

class TempViewController: UIViewController {
    
    
    private let stackView = UIStackView(
        frame: .zero
    ).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    private let username = UITextField()
    private let password = UITextField()
    private let goal = UITextField()
    private let btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addView()
        self.configure()
    }
    
    func addView(){
        self.view.addSubview(stackView)
        [username, password, goal, btn].map {
            self.stackView.addArrangedSubview($0)
        }
    }
    
    func configure(){
        username.placeholder = "아이디"
        password.placeholder = "비밀번호"
        goal.placeholder = "목표"
        btn.titleLabel?.text = "버튼"
        btn.backgroundColor = .Main_30
        btn.snp.makeConstraints{
            $0.height.equalTo(50)
        }
        stackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        btn.addTarget(self, action: #selector(sendData), for: .touchUpInside)
    }
    
    @objc func sendData(){
        guard let username = username.text,
              let password = password.text,
              let goal = goal.text else {return;}
        
        SignUpDataManager().signUp(username, password, goal, self) { signUpData in
            
            Constant.USER_ID = signUpData.userID
            Constant.USER_JWTTOKEN = signUpData.jwt
            let baseTabBarController = BaseTabBarViewController()
            self.dismissIndicator()
            self.dismiss(animated: true)
            self.changeRootViewController(baseTabBarController)
            
            
        }
    }
}
