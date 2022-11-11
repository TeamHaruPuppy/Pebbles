import UIKit
import SnapKit


//protocol showCalendarProtocol {
//    func startBtnTapped()
//    func endBtnTapped()
//}

class AddPebbleTableViewCell: UITableViewCell{
    
    static let identifier = "AddPebbleTableViewCell"

    @IBOutlet weak var pebbleNameLabel: UILabel!
    @IBOutlet weak var pebbleNameTextField: UITextField!
    
    @IBOutlet weak var startDay: UILabel!
    @IBOutlet weak var endDay: UILabel!
    @IBOutlet weak var doDay: UILabel!
    
    @IBOutlet weak var startWeekImg: UIImageView!
    @IBOutlet weak var endWeekImg: UIImageView!
    
    @IBOutlet weak var startDayLabel: UILabel!
    @IBOutlet weak var endDayLabel: UILabel!
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    
    @IBOutlet weak var startHighlight: UIView!
    @IBOutlet weak var endHighlight: UIView!
    
    @IBOutlet weak var weeksStackView: UIStackView!
    @IBOutlet weak var monBtn: UIButton!
    @IBOutlet weak var tueBtn: UIButton!
    @IBOutlet weak var wedBtn: UIButton!
    @IBOutlet weak var thuBtn: UIButton!
    @IBOutlet weak var friBtn: UIButton!
    @IBOutlet weak var satBtn: UIButton!
    @IBOutlet weak var sunBtn: UIButton!
    
    @IBOutlet weak var addHabitBtn: UIButton!
    @IBOutlet weak var addPebbleStackView: UIStackView!
    @IBOutlet weak var addImg: UIImageView!
    @IBOutlet weak var addLabel: UILabel!
    
//    var delegate : showCalendarProtocol!
    weak var viewController: UIViewController? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setInit()
    }

    func setInit(){
        self.setConfigure()
        self.setAttribute()
    }
    
    func setAttribute(){
        self.contentView.backgroundColor = .White
        
        pebbleNameLabel.textColor = .Gray_60
        pebbleNameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        
        pebbleNameTextField.layer.borderWidth = 1
        pebbleNameTextField.layer.borderColor = UIColor.Gray_30.cgColor
        pebbleNameTextField.layer.masksToBounds = true
        pebbleNameTextField.layer.cornerRadius = 10
        pebbleNameTextField.placeholder = "하루에 할 일을 적어주세요"
        pebbleNameTextField.setPlaceholderColor(.Gray_30)
        pebbleNameTextField.backgroundColor = .White
        
        startDay.textColor = .Gray_40
        startDay.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
        endDay.textColor = .Gray_40
        endDay.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
        doDay.textColor = .Gray_40
        doDay.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
        startDayLabel.textColor = .Gray_30
        startDayLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        startDayLabel.text = "날짜를 선택 해 주세요"
        startDayLabel.textColor = .Gray_30
        
        endDayLabel.textColor = .Gray_30
        endDayLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        endDayLabel.text = "날짜를 선택 해 주세요"
        endDayLabel.textColor = .Gray_30
        
        monBtn.layer.masksToBounds = true
        monBtn.layer.borderWidth = 0
        monBtn.layer.cornerRadius = Constant.edgeWidth*18
        monBtn.isSelected = false
        monBtn.titleLabel?.textColor = .Gray_30
        monBtn.titleLabel?.text = "월"
        monBtn.backgroundColor = .Gray_10
        
        tueBtn.layer.masksToBounds = true
        tueBtn.layer.borderWidth = 0
        tueBtn.layer.cornerRadius = 18
        tueBtn.isSelected = false
        tueBtn.titleLabel?.textColor = .Gray_30
        tueBtn.titleLabel?.text = "화"
        tueBtn.backgroundColor = .Gray_10
        
        wedBtn.layer.masksToBounds = true
        wedBtn.layer.borderWidth = 0
        wedBtn.layer.cornerRadius = 18
        wedBtn.isSelected = false
        wedBtn.titleLabel?.textColor = .Gray_30
        wedBtn.titleLabel?.text = "수"
        wedBtn.backgroundColor = .Gray_10
        
        thuBtn.layer.masksToBounds = true
        thuBtn.layer.borderWidth = 0
        thuBtn.layer.cornerRadius = 18
        thuBtn.isSelected = false
        thuBtn.titleLabel?.textColor = .Gray_30
        thuBtn.titleLabel?.text = "목"
        thuBtn.backgroundColor = .Gray_10
        
        friBtn.layer.masksToBounds = true
        friBtn.layer.borderWidth = 0
        friBtn.layer.cornerRadius = 18
        friBtn.isSelected = false
        friBtn.titleLabel?.textColor = .Gray_30
        friBtn.titleLabel?.text = "금"
        friBtn.backgroundColor = .Gray_10
        
        satBtn.layer.masksToBounds = true
        satBtn.layer.borderWidth = 0
        satBtn.layer.cornerRadius = 18
        satBtn.isSelected = false
        satBtn.titleLabel?.textColor = .Gray_30
        satBtn.titleLabel?.text = "토"
        satBtn.backgroundColor = .Gray_10
        
        sunBtn.layer.masksToBounds = true
        sunBtn.layer.borderWidth = 0
        sunBtn.layer.cornerRadius = 18
        sunBtn.isSelected = false
        sunBtn.titleLabel?.textColor = .Gray_30
        sunBtn.titleLabel?.text = "일"
        sunBtn.backgroundColor = .Gray_10
        
        addHabitBtn.layer.borderWidth = 1
        addHabitBtn.layer.borderColor = UIColor.Main_10.cgColor
        addHabitBtn.layer.masksToBounds = true
        addHabitBtn.layer.cornerRadius = 8
        
        addLabel.textColor = .Main_30
        addLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
    }
    func setConfigure(){
        pebbleNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Constant.edgeHeight*20)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        pebbleNameTextField.snp.makeConstraints{
            $0.top.equalTo(pebbleNameLabel.snp.bottom).offset(Constant.edgeHeight*20)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.width.equalTo(Device.width-Constant.edgeWidth*40)
            $0.height.equalTo(Constant.edgeHeight*50)
        }
        
        startDay.snp.makeConstraints{
            $0.top.equalTo(pebbleNameTextField.snp.bottom).offset(Constant.edgeHeight*30)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        endDay.snp.makeConstraints{
            $0.top.equalTo(startDay.snp.bottom).offset(Constant.edgeHeight*30)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        doDay.snp.makeConstraints{
            $0.top.equalTo(endDay.snp.bottom).offset(Constant.edgeHeight*30)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        
        startDayLabel.snp.makeConstraints{
            $0.right.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.centerY.equalTo(startDay)
        }
        endDayLabel.snp.makeConstraints{
            $0.right.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.centerY.equalTo(endDay)
        }
        
        startWeekImg.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*16)
            $0.width.equalTo(Constant.edgeHeight*16)
            $0.centerY.equalTo(startDayLabel)
            $0.right.equalTo(startDayLabel.snp.left).inset(-Constant.edgeWidth*10)
        }
        endWeekImg.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*16)
            $0.width.equalTo(Constant.edgeHeight*16)
            $0.centerY.equalTo(endDayLabel)
            $0.right.equalTo(endDayLabel.snp.left).inset(-Constant.edgeWidth*10)
        }
        
        startBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*32)
            $0.top.equalTo(pebbleNameTextField.snp.bottom).offset(20)
            $0.left.equalTo(startWeekImg.snp.left)
            $0.right.equalTo(startDayLabel.snp.right)
        }
        
        endBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*32)
            $0.top.equalTo(startBtn.snp.bottom).offset(10)
            $0.left.equalTo(endWeekImg.snp.left)
            $0.right.equalTo(endDayLabel.snp.right)
        }
        
        startHighlight.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.width.equalTo(startBtn)
            $0.left.equalTo(startBtn)
            $0.top.equalTo(startDayLabel.snp.bottom).offset(Constant.edgeHeight*3)
        }
        endHighlight.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.width.equalTo(endBtn)
            $0.left.equalTo(endBtn)
            $0.top.equalTo(endDayLabel.snp.bottom).offset(Constant.edgeHeight*3)
        }
        
        weeksStackView.snp.makeConstraints{
            $0.top.equalTo(doDay.snp.bottom).offset(Constant.edgeHeight*12)
            $0.left.right.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        monBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*36)
            $0.width.equalTo(Constant.edgeWidth*36)
        }
        tueBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*36)
            $0.width.equalTo(Constant.edgeWidth*36)
        }
        wedBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*36)
            $0.width.equalTo(Constant.edgeWidth*36)
        }
        thuBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*36)
            $0.width.equalTo(Constant.edgeWidth*36)
        }
        friBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*36)
            $0.width.equalTo(Constant.edgeWidth*36)
        }
        satBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*36)
            $0.width.equalTo(Constant.edgeWidth*36)
        }
        sunBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*36)
            $0.width.equalTo(Constant.edgeWidth*36)
        }
        
        addHabitBtn.snp.makeConstraints{
            $0.top.equalTo(weeksStackView.snp.bottom).offset(Constant.edgeHeight*20)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.width.equalTo(Device.width - Constant.edgeWidth*40)
            $0.height.equalTo(Constant.edgeHeight*50)
        }
        addImg.snp.makeConstraints{
            $0.width.equalTo(Constant.edgeWidth*14)
            $0.height.equalTo(Constant.edgeHeight*14)
        }
        
        addPebbleStackView.snp.makeConstraints{
            $0.center.equalTo(addHabitBtn)
        }
        
    }
    
    func setWeekBtnState(_ sender : UIButton){
        sender.isSelected.toggle()
        if sender.isSelected{
            sender.titleLabel?.textColor = .White
            sender.backgroundColor = .Main_30
        }
        else{
            sender.titleLabel?.textColor = .Gray_30
            sender.backgroundColor = .Gray_10
        }
    }
    
    @IBAction func startBtnTapped(_ sender: Any) {
//        self.delegate.startBtnTapped()
        Constant.startOrEnd = false
        let vc = CalendarPopUpViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        viewController?.present(vc, animated: false)
        
    }
    @IBAction func endBtnTapped(_ sender: Any) {
//        self.delegate.endBtnTapped()
        Constant.startOrEnd = true
        let vc = CalendarPopUpViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        viewController?.present(vc, animated: false)
    }
    
    @IBAction func monBtnTapped(_ sender: UIButton) {
        setWeekBtnState(sender)
    }
    @IBAction func tueBtnTapped(_ sender: UIButton) {
        setWeekBtnState(sender)
    }
    @IBAction func wedBtnTapped(_ sender: UIButton) {
        setWeekBtnState(sender)
    }
    @IBAction func thuBtnTapped(_ sender: UIButton) {
        setWeekBtnState(sender)
    }
    @IBAction func friBtnTapped(_ sender: UIButton) {
        setWeekBtnState(sender)
    }
    @IBAction func satBtnTapped(_ sender: UIButton) {
        setWeekBtnState(sender)
    }
    @IBAction func sunBtnTapped(_ sender: UIButton) {
        setWeekBtnState(sender)
    }

    @IBAction func addPebbleBtnTapped(_ sender: Any) {
    }
}

extension AddPebbleTableViewCell : DateTimePickerVCDelegate{
    func updateDateTime(_ dateTime: String) {
        if Constant.startOrEnd == false{
            self.startDayLabel.text = dateTime
            self.startDayLabel.textColor = .Gray_60
            Constant.startStatus = true
            if Constant.goalStatus && Constant.startStatus && Constant.endStatus{
                
            }
            else {
                
            }
            print("지금 각 상태별 상황은? : 텍스트필드-> \(Constant.goalStatus) 시작날짜-> \(Constant.startStatus) 종료날짜-> \(Constant.endStatus)")
        }
        else {
            self.endDayLabel.text = dateTime
            self.endDayLabel.textColor = .Gray_60
            Constant.endStatus = true
            if Constant.goalStatus && Constant.startStatus && Constant.endStatus{
               
            }
            else {
                
            }
            print("지금 각 상태별 상황은? : 텍스트필드-> \(Constant.goalStatus) 시작날짜-> \(Constant.startStatus) 종료날짜-> \(Constant.endStatus)")
        }
    }
}
