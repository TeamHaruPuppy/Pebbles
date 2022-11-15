import UIKit
import SnapKit


protocol enterCompHabitDelegate {
    func trueEnter(_ T : Bool, _ index : Int)
    func falseEnter(_ F : Bool, _ index : Int)
    func deleteHabitIndex(_ index : Int)
    func getHabitData(_ habit : ReqHabit)
}

class AddPebbleTableViewCell: UITableViewCell{
    
    static let identifier = "AddPebbleTableViewCell"
    
    var enterStart = false
    var enterEnd = false
    var enterText = false
    var enterWeek : [String] = []
    var habit : ReqHabit = ReqHabit(days: [], end: "", name: "", seq: 0, start: "", todos: [], weeks: ReqWeeks(fri: false, mon: false, sat: false, sun: false, thu: false, tue: false, wed: false))
    
    var startDayValue = Date()
    var endDayValue = Date()
    
    //MARK: - 요일별 날짜 계산하기 위해 시작날짜 종료날짜 저장하는 용도
    var calcuStart = Date()
    var calcuEnd = Date()

    @IBOutlet weak var headerView: UIView!
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
    
    @IBOutlet weak var deleteHabitBtn: UIButton!
    
    var delegate : enterCompHabitDelegate!
    
    weak var viewController: UIViewController? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setInit()
        pebbleNameTextField.delegate = self
        
    }
    
    override func prepareForReuse() {
        self.setInit()
    }

    func setInit(){
        self.setConfigure()
        self.setAttribute()
        self.dateInit()
    }
    
    func setAttribute(){
        self.contentView.backgroundColor = .White
        
        pebbleNameLabel.textColor = .Gray_60
        pebbleNameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        
        pebbleNameTextField.layer.borderWidth = 1
        pebbleNameTextField.layer.borderColor = UIColor.Gray_30.cgColor
        pebbleNameTextField.layer.masksToBounds = true
        pebbleNameTextField.layer.cornerRadius = 10
        pebbleNameTextField.text = ""
        pebbleNameTextField.placeholder = "하루에 할 일을 적어주세요!"
        pebbleNameTextField.setPlaceholderColor(.Gray_30)
        pebbleNameTextField.backgroundColor = .White
        pebbleNameTextField.textColor = .Black
        
        startDay.textColor = .Gray_40
        startDay.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
        endDay.textColor = .Gray_40
        endDay.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
        doDay.textColor = .Gray_40
        doDay.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
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
        
        deleteHabitBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
    }
    
    func dateInit(){
        startDayLabel.textColor = .Gray_30
        startDayLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        startDayLabel.text = "날짜를 선택 해 주세요"
        startDayLabel.textColor = .Gray_30
        
        endDayLabel.textColor = .Gray_30
        endDayLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        endDayLabel.text = "날짜를 선택 해 주세요"
        endDayLabel.textColor = .Gray_30
        
        enterStart = false
        enterEnd = false
        
        startBtn.isEnabled = true
        endBtn.isEnabled = false
        
        for (key, value) in Constant.POST_ROCK_DATE{
            startDayValue = key
            endDayValue = value
            print("Key는 \(key): , Value : \(value)")
        }
        
    }
    
    func setConfigure(){
        
        headerView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(Constant.edgeHeight*7)
        }
        
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
        
        deleteHabitBtn.snp.makeConstraints{
            $0.top.equalTo(weeksStackView.snp.bottom).offset(Constant.edgeHeight*20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Device.width - Constant.edgeWidth*300)
            $0.height.equalTo(Constant.edgeHeight*32)
        }
        
        
    }
    
    func setWeekBtnState(_ sender : UIButton){
        sender.isSelected.toggle()
        if sender.isSelected{
            sender.titleLabel?.textColor = .White
            sender.backgroundColor = .Main_30
            enterWeek.append(sender.titleLabel?.text ?? "")
            
            print("주간 체크했을 때 상태 머야 : ")
            print("해빗이름 : \(enterText) | 시작 날짜: \(enterStart) | 종료 날짜: \(enterEnd) | 주간 선택 : \(enterWeek.isEmpty)")
            if enterText && enterStart && enterStart && !enterWeek.isEmpty{
                self.delegate.trueEnter(true, deleteHabitBtn.tag)
            }
        }
        else{
            sender.titleLabel?.textColor = .Gray_30
            sender.backgroundColor = .Gray_10
            if let index = enterWeek.firstIndex(of: sender.titleLabel?.text ?? "") {
                enterWeek.remove(at: index)
            }
            if enterWeek.isEmpty {
                self.delegate.falseEnter(false, deleteHabitBtn.tag)
            }
        }
        print("활성화 된 요일은 ?? : \(enterWeek)")
    }
    
    @IBAction func startBtnTapped(_ sender: Any) {
        Constant.startOrEnd = false
        //MARK: - 날짜 설정 초기화
        self.dateInit()
        let vc = CalendarPopUpViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.start = startDayValue
        vc.end = endDayValue
        viewController?.present(vc, animated: false)
        
    }
    @IBAction func endBtnTapped(_ sender: Any) {
        Constant.startOrEnd = true
        
        for (key, value) in Constant.POST_ROCK_DATE{
//            startDayValue = key
            endDayValue = value
            print("Key는 \(key): , Value : \(value)")
        }
        
        let vc = CalendarPopUpViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.start = startDayValue
        vc.end = endDayValue
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

    @IBAction func deletePebbleBtnTapped(_ sender: UIButton) {
        self.delegate.deleteHabitIndex(deleteHabitBtn.tag)
    }
}

extension AddPebbleTableViewCell : DateTimePickerVCDelegate{
    
    func changeStartToEnd(_ start: Bool, _ startDate: Date, _ endDate: Date) {
        if start {
            self.endDayValue = endDate
            self.startDayValue = startDate
            endBtn.isEnabled = true
        }
    }
    
    func updateDateTime(_ dateTime: Date) {
        if Constant.startOrEnd == false{
            self.startDayLabel.text = dateTime.text
            self.startDayLabel.textColor = .Gray_60
            enterStart = true
            calcuStart = dateTime
        }
        else {
            self.endDayLabel.text = dateTime.text
            self.endDayLabel.textColor = .Gray_60
            enterEnd = true
            calcuEnd = dateTime
            if enterText && enterEnd && enterStart && !enterWeek.isEmpty{
                self.delegate.trueEnter(true, deleteHabitBtn.tag)
            }
        }
    }
}


extension AddPebbleTableViewCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text != ""{
            enterText = true
            if enterText && enterEnd && enterStart && !enterWeek.isEmpty{
                self.delegate.trueEnter(true, deleteHabitBtn.tag)
            }
            else{
                self.delegate.falseEnter(false, deleteHabitBtn.tag)
            }
        }
        else{
            enterText = false
        }
        self.pebbleNameTextField.text = textField.text
        return true
    }
}


extension AddPebbleTableViewCell {
    
    func calculateHabitData(_ complition : @escaping (_ data : ReqHabit) -> Void){
        self.habit.start = startDayLabel.text ?? ""
        self.habit.end = endDayLabel.text ?? ""
        self.habit.name = pebbleNameTextField.text ?? ""
        
        //MARK: - Constant.HABIT_SEQ는 추가 이후에 초기화 해 줘야한다.
        self.habit.seq = Constant.HABIT_SEQ
        
        for idx in enterWeek{
            switch idx {
            case "월":
                self.habit.weeks.mon = true
                calculateDays("Mon")
            case "화":
                self.habit.weeks.tue = true
                calculateDays("Tue")
            case "수":
                self.habit.weeks.wed = true
                calculateDays("Wed")
            case "목":
                self.habit.weeks.thu = true
                calculateDays("Thu")
            case "금":
                self.habit.weeks.fri = true
                calculateDays("Fri")
            case "토":
                self.habit.weeks.sat = true
                calculateDays("Sat")
            default:
                self.habit.weeks.sun = true
                calculateDays("Sun")
            }
        }
        complition(self.habit)
    }
    
    // 시작날짜 -> 처음 week 찾고
    
    func calculateDays(_ week : String) {
        var start = calcuStart
        var end = calcuEnd
        while start.onlyWeek != week {
            start = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        }
        while start.text <= end.text {
            self.habit.days.append(start.text)
            start = Calendar.current.date(byAdding: .day, value: 7, to: start)!
        }
    }
}
