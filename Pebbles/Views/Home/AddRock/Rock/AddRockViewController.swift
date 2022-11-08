import UIKit
import SnapKit

class AddRockViewController: UIViewController{
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    
    
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalTextField: UITextField!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startStackView: UIStackView!
    @IBOutlet weak var startSelectBtn: UIButton!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var startHighlight: UIView!
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endStackView: UIStackView!
    @IBOutlet weak var endSelectBtn: UIButton!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var endHighlight: UIView!
    
    @IBOutlet weak var startCalendarBtn: UIButton!
    @IBOutlet weak var endCalendarBtn: UIButton!
    
    
    @IBOutlet weak var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfigure()
        self.setAttribute()
        
        goalTextField.delegate = self
        
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
            $0.height.width.equalTo(28)
            $0.left.equalTo(appBar.snp.left).inset(20)
        }
        backImg.snp.makeConstraints{
            $0.centerX.centerY.equalTo(backBtn)
            $0.height.width.equalTo(20)
        }
        titleLabel.snp.makeConstraints{
            $0.centerY.equalTo(appBar.snp.centerY)
            $0.centerX.equalTo(appBar.snp.centerX)
        }
       
        
        introLabel.snp.makeConstraints{
            $0.top.equalTo(appBar.snp.bottom)
            $0.left.equalToSuperview().inset(20)
        }
        
        goalLabel.snp.makeConstraints{
            $0.top.equalTo(introLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(20)
        }
        
        goalTextField.snp.makeConstraints{
            $0.top.equalTo(goalLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.width.equalTo(Device.width-40)
        }
        
        startDateLabel.snp.makeConstraints{
            $0.top.equalTo(goalTextField.snp.bottom).offset(30)
            $0.left.equalToSuperview().inset(20)
        }
        
        endDateLabel.snp.makeConstraints{
            $0.top.equalTo(startDateLabel.snp.bottom).offset(28)
            $0.left.equalToSuperview().inset(20)
        }
        
        startStackView.snp.makeConstraints{
            $0.centerY.equalTo(startDateLabel)
            $0.right.equalTo(goalTextField.snp.right).inset(20)
        }
        
        startSelectBtn.snp.makeConstraints{
            $0.width.height.equalTo(20)
        }
        
        startHighlight.snp.makeConstraints{
            $0.top.equalTo(startStackView.snp.bottom).offset(2)
            $0.left.equalTo(startStackView.snp.left)
            $0.width.equalTo(startStackView.snp.width)
            $0.height.equalTo(1)
        }
        
        endStackView.snp.makeConstraints{
            $0.centerY.equalTo(endDateLabel)
            $0.right.equalTo(goalTextField.snp.right).inset(20)
        }
        
        endSelectBtn.snp.makeConstraints{
            $0.width.height.equalTo(20)
        }
        
        endHighlight.snp.makeConstraints{
            $0.top.equalTo(endStackView.snp.bottom).offset(2)
            $0.left.equalTo(endStackView.snp.left)
            $0.width.equalTo(endStackView.snp.width)
            $0.height.equalTo(1)
        }
        
        startCalendarBtn.snp.makeConstraints{
            $0.centerY.centerX.equalTo(startStackView)
            $0.width.equalTo(Constant.edgeWidth*110)
            $0.height.equalTo(Constant.edgeHeight*36)
        }
        
        endCalendarBtn.snp.makeConstraints{
            $0.centerY.centerX.equalTo(endStackView)
            $0.width.equalTo(Constant.edgeWidth*110)
            $0.height.equalTo(Constant.edgeHeight*36)
        }
        
        
        nextBtn.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(44)
        }
        
        
        
    }
    func setAttribute(){
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .White
        backImg.tintColor = .Main_30
        titleLabel.textColor = .Gray_60
        goalTextField.backgroundColor = .White
        startDate.textColor = .black
        endDate.textColor = .black
        startDateLabel.textColor = .Gray_40
        endDateLabel.textColor = .Gray_40
        introLabel.textColor = .Gray_60
        
        
        startDateLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        endDateLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
        
        goalTextField.placeholder = "예시) 한 달 동안 책 5권 읽기."
        goalTextField.setPlaceholderColor(.Gray_30)
        goalTextField.layer.borderWidth = 1
        goalTextField.layer.borderColor = UIColor.Gray_30.cgColor
        goalTextField.layer.masksToBounds = true
        goalTextField.layer.cornerRadius = 10
        goalTextField.textColor = .Black
        goalTextField.returnKeyType = .done
        
        startDate.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        startDate.text = "날짜를 선택 해 주세요"
        startDate.textColor = .Gray_30
        endDate.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        endDate.text = "날짜를 선택 해 주세요"
        endDate.textColor = .Gray_30
        
        startHighlight.backgroundColor = .Gray_30
        endHighlight.backgroundColor = .Gray_30
        
        backBtn.isEnabled = true
        
        startSelectBtn.isEnabled = false
        endSelectBtn.isEnabled = false
        
        nextBtn.isEnabled = false
        nextBtn.isSelected = false
        nextBtn.tintColor = .White
        nextBtn.backgroundColor = .Gray_30
        
        
    }
    
    @IBAction func startDateBtnTapped(_ sender: Any) {
        Constant.startOrEnd = false
        let vc = CalendarPopUpViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    
    @IBAction func endDateBtnTapped(_ sender: Any) {
        Constant.startOrEnd = true
        let vc = CalendarPopUpViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        Constant.POST_HIGHLIGHT.name = "\(String(describing: goalTextField.text))"
        Constant.POST_HIGHLIGHT.start = "\(String(describing: startDate.text))"
        Constant.POST_HIGHLIGHT.end = "\(String(describing: endDate.text))"
        let pebbles = AddPebblesViewController()
        navigationController?.pushViewController(pebbles, animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        print("왜 안대")
        let rootVC = HomeViewController()
        let rootViewController = UINavigationController(rootViewController: rootVC)
        UIApplication.shared.keyWindow?.switchRootViewController(rootViewController,options: .transitionCurlDown)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.goalTextField.endEditing(true)
        
        if goalTextField.text != ""{
            Constant.goalStatus = true
        }
        else{
            Constant.goalStatus = false
        }
        
        if Constant.goalStatus && Constant.startStatus && Constant.endStatus{
            nextBtn.backgroundColor = .Main_30
            nextBtn.isEnabled.toggle()
        }
        else {
            nextBtn.backgroundColor = .Gray_30
            nextBtn.isEnabled.toggle()
        }
        
        print("지금 각 상태별 상황은? : 텍스트필드-> \(Constant.goalStatus) 시작날짜-> \(Constant.startStatus) 종료날짜-> \(Constant.endStatus)")
    }
}

extension AddRockViewController : DateTimePickerVCDelegate{
    func updateDateTime(_ dateTime: String) {
        if Constant.startOrEnd == false{
            self.startDate.text = dateTime
            self.startDate.textColor = .Gray_60
            Constant.startStatus = true
            if Constant.goalStatus && Constant.startStatus && Constant.endStatus{
                nextBtn.backgroundColor = .Main_30
                nextBtn.isEnabled.toggle()
            }
            else {
                nextBtn.backgroundColor = .Gray_30
                nextBtn.isEnabled = false
            }
            print("지금 각 상태별 상황은? : 텍스트필드-> \(Constant.goalStatus) 시작날짜-> \(Constant.startStatus) 종료날짜-> \(Constant.endStatus)")
        }
        else {
            self.endDate.text = dateTime
            self.endDate.textColor = .Gray_60
            Constant.endStatus = true
            if Constant.goalStatus && Constant.startStatus && Constant.endStatus{
                nextBtn.backgroundColor = .Main_30
                nextBtn.isEnabled.toggle()
            }
            else {
                nextBtn.backgroundColor = .Gray_30
                nextBtn.isEnabled = false
            }
            print("지금 각 상태별 상황은? : 텍스트필드-> \(Constant.goalStatus) 시작날짜-> \(Constant.startStatus) 종료날짜-> \(Constant.endStatus)")
        }
    }
}

extension AddRockViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if textField.text != ""{
            Constant.goalStatus = true
        }
        
        if Constant.goalStatus && Constant.startStatus && Constant.endStatus{
            nextBtn.backgroundColor = .Main_30
            nextBtn.isEnabled.toggle()
        }
        else {
            nextBtn.backgroundColor = .Gray_30
            nextBtn.isEnabled.toggle()
        }
        
        print("지금 각 상태별 상황은? : 텍스트필드-> \(Constant.goalStatus) 시작날짜-> \(Constant.startStatus) 종료날짜-> \(Constant.endStatus)")
        return true
    }
   
}


