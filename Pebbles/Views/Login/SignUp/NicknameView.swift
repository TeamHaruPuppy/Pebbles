import Then
import SnapKit
import UIKit

protocol ChangeBtnDelegate : class {
    func isNextBtnEnabled()
    func isNotNextBtnEnabled()
}



class NicknameView: UIView  {
    
    let nicknameViewModel = WriteNickNameViewModel()
    weak var delegate : ChangeBtnDelegate?
    
    
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var repeatedCheckBtn: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var initialCount: UILabel!
    
    var count = 0
    var charCheck = true
    
    // T : 글자 수 에러 & F : 정규화 에러
    var isNicknameError : [Bool] = []
    
    var isNicknameCount = true
    var isNicknameNormalization = true
    var isTextFieldEmpty = true
    
    var isRepeatCheck = true
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK: 커스텀한 뷰의 IBOutlet등의 초기화를 담당하는 함수 (ViewController의 ViewDidLoad와 같은 역할)
    override func awakeFromNib() {
//        textField.delegate = self
        configure()
        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_ :)), for: .allEditingEvents)
    }
    
    
    //MARK: TextField 변경 감지해서 경고메세지 출력
    @objc func textFieldDidChange(_ sender : Any){
        guard let nickname = textField.text else {return}
        initialCount.text = "\(nickname.count) / 5"
        
        
        if isNicknameError.count == 0 && nickname.count >= 0{
            if(nickname.count == 0){
                textField.layer.borderColor = UIColor.Gray_30.cgColor
                errorMessageLabel.textColor = .Gray_60
                errorMessageLabel.text = ""
                repeatedCheckBtn.isEnabled = false
                initialCount.textColor = .Gray_40
            }
            else {
                textField.layer.borderColor = UIColor.Main_30.cgColor
                errorMessageLabel.textColor = .Gray_60
                errorMessageLabel.text = ""
                repeatedCheckBtn.isEnabled = true
                initialCount.textColor = .Gray_40
            }
        }
        else{
            if isNicknameError.last == true{
                errorMessageLabel.textColor = .alart
                errorMessageLabel.text = "닉네임은 5자를 초과할 수 없습니다."
                initialCount.textColor = .alart
            }
            else if isNicknameError.last == false{
                errorMessageLabel.textColor = .alart
                errorMessageLabel.text = "특수문자나 이모티콘은 입력할 수 없습니다."
                initialCount.textColor = .alart
            }
            textField.layer.borderColor = UIColor.alart.cgColor
            repeatedCheckBtn.isEnabled = false
        }
    }
    
    func configure(){
        
        
        mainTitleLabel.textColor = .Gray_60
        subTitleLabel.textColor = .Gray_50
        initialCount.textColor = .Gray_40
        
        textField.backgroundColor = .white
        textField.placeholder = "특수문자는 사용할 수 없습니다."
        textField.textColor = .black
        textField.setPlaceholderColor(.Gray_30)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.Gray_30.cgColor
        
        mainTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Constant.edgeHeight * 30)
            $0.left.equalToSuperview().inset(Constant.edgeWidth * 20)
        }
        
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(Constant.edgeHeight * 8)
            $0.left.equalToSuperview().inset(Constant.edgeWidth * 20)
        }
        
        textField.snp.makeConstraints{
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(Constant.edgeHeight * 25)
            $0.left.equalToSuperview().inset(Constant.edgeWidth * 20)
        }
        
        errorMessageLabel.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(Constant.edgeHeight * 8)
            $0.left.equalToSuperview().inset(Constant.edgeWidth * 28)
        }
        
        initialCount.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(Constant.edgeHeight * 8)
            $0.right.equalToSuperview().inset(Constant.edgeWidth * 28)
        }
        
        errorMessageLabel.text = ""
        initialCount.text = "\(count) / 5"
    }
    
    
    @IBAction func repeatedCheckBtnTapped(_ sender: Any) {
        //MARK: 중복확인 API호출 후, 결과를 가지고 delegate호출
        var canNext : Bool = true
        
        if canNext{
            errorMessageLabel.text = "사용가능한 닉네임 입니다."
            errorMessageLabel.textColor = .Main_30
            self.delegate?.isNextBtnEnabled()
        }
        else{
            self.delegate?.isNotNextBtnEnabled()
        }
                
                
    }
    
    
    
    
}

//extension NicknameView : UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let utf8Char = string.cString(using: .utf8)
//        let isBackSpace = strcmp(utf8Char, "\\b")
//
//        if isBackSpace == -92{
//            self.delegate?.isNotNextBtnEnabled()
//            if isNicknameError.count > 0{
//                isNicknameError.removeLast()
//                print("에러배열 하나 지움. 현재 에러배열 크기 :\(isNicknameError.count)")
//                print("마지막 에러 종류는: \(isNicknameError.last)")
//            }
//        }else if !string.hasCharacters(){
//            isNicknameError.append(false)
//            print("특수문자 집어넣음. 현재 에러배열 크기 : \(isNicknameError.count)")
//            print("마지막 에러 종류는: \(isNicknameError.last)")
//        }else {
//            let nickname = textField.text ?? ""
//            if nickname.count >= 5 {isNicknameError.append(true)}
//            print("5글자 이상임. 현재 에러배열 크기 : \(isNicknameError.count)")
//            print("마지막 에러 종류는: \(isNicknameError.last)")
//        }
//        return true
//    }
//}


