import SnapKit
import UIKit

protocol DateTimePickerVCDelegate: AnyObject {
    func updateDateTime(_ dateTime: String)
}

class CalendarPopUpViewController: UIViewController {
    
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var baseView: UIView!
    weak var delegate: DateTimePickerVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        initUI()
    }
    
    func initUI() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.backView.addGestureRecognizer(tapGesture)
        
        self.setConfigure()
        self.setAttribute()
        self.setDatePicker()
        
        
    }
    
    func setAttribute(){
        saveBtn.tintColor = .Main_30
        backView.backgroundColor = .Gray_30
        backView.alpha = 0.5
        baseView.backgroundColor = .White
        baseView.layer.masksToBounds = true
        baseView.layer.borderWidth = 0
        baseView.layer.cornerRadius = 14
    }
    
    func setConfigure(){
        backView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        baseView.snp.makeConstraints{
            $0.centerY.centerX.equalToSuperview()
            $0.width.equalTo(Constant.edgeWidth*335)
            $0.height.equalTo(Constant.edgeHeight*415)
        }
        
        datePicker.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(360)
        }
        
        saveBtn.snp.makeConstraints{
            $0.top.equalTo(datePicker.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func setDatePicker() {
        datePicker.preferredDatePickerStyle = .inline
        // locale 설정을 해주고
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.calendar.locale = Locale(identifier: "ko_KR")
        
        // 현재 시간에 맞게 자동으로 업데이트 하게 해주고
        datePicker.timeZone = .autoupdatingCurrent
        
        // 피커에 달력과 시간을 설정하는 것 두개를 다 사용할 것입니다.
        datePicker.datePickerMode = .date
        datePicker.sizeToFit()
        
        // 피커의 데이터를 선택했을 때 어떤 동작을 하게 할지 addTarget도 추가해볼 수 있습니다.
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        datePicker.overrideUserInterfaceStyle = .light
        // 선택된 날짜, 주된 컬러를 설정
        datePicker.tintColor = .Main_30
        // 오늘로부터 과거 날짜 블러처리
        print("시작이니 종료니?? : \(Constant.startOrEnd)")
        print("시작날짜 : \(Constant.rockStartDay)")
        print("종료날짜 : \(Constant.rockEndDay)")
        print("기준 날짜: \(Date())")
        if Constant.startOrEnd == false{
            datePicker.minimumDate = Date()
            if Constant.rockEndDay.text != Date().text{
                datePicker.maximumDate = Constant.rockEndDay
            }
        }
        else{
            datePicker.minimumDate = Constant.rockStartDay

        }
        
    }
    
    // 피커의 데이터를 선택했을 때 어떤 행위를 할지 정의해주는 함수
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        // datePicker의 format 형식을 정의해줍니다.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        
        dateFormatter.string(from: self.datePicker.date)
        if Constant.startOrEnd == false{
            Constant.rockStartDay = self.datePicker.date
            
        }
        else{
            Constant.rockEndDay = self.datePicker.date
        }
        self.delegate?.updateDateTime(dateFormatter.string(from: self.datePicker.date))
        self.dismiss(animated: false)
    }
}

extension CalendarPopUpViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        self.dismiss(animated: false)
        return true
    }
}
