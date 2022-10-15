import UIKit
import SnapKit
import Then
import FSCalendar

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var weekMonthBtn: UIButton!
    @IBOutlet weak var preventBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    private var customView = UIView()
    
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 M월"
        return df
    }()
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        setCalendar()
    }
    
    private let logoImageView = UIImageView().then{
        $0.image = UIImage(named: "mainLogo.png")!
        $0.contentMode = .scaleAspectFill
    }
    
    private let optionBtn = UIButton().then{
        $0.setImage(UIImage(named: "option.png"), for: .normal)
    }
    
    private var calendarView = FSCalendar().then{
        $0.backgroundColor = .white
        $0.appearance.titleDefaultColor = .black
        $0.appearance.titleWeekendColor = .red
        $0.appearance.headerTitleColor = .Gray_60
        $0.appearance.weekdayTextColor = .Gray_40
        
        $0.appearance.headerTitleFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.appearance.weekdayFont = UIFont(name :"AppleSDGothicNeo-Medium", size: 13)
        $0.appearance.titleFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.appearance.headerTitleColor = .Gray_60
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerTitleAlignment = .left
        $0.appearance.borderRadius = 14
        $0.clipsToBounds = true
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.locale = Locale(identifier: "ko_KR")
        
        
    }
    
    private var backView = UIView().then{
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.borderWidth = 0
        $0.layer.cornerRadius = 14
    }

    private var shadow = UIView().then{
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 14
        $0.layer.shadowOpacity = 0.1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        
        self.view.addSubview(logoImageView)
        self.view.addSubview(optionBtn)
        self.view.addSubview(shadow)
        self.shadow.addSubview(backView)
        self.backView.addSubview(headerLabel)
        self.backView.addSubview(weekMonthBtn)
        self.backView.addSubview(nextBtn)
        self.backView.addSubview(preventBtn)
        self.backView.addSubview(calendarView)
        
        self.configure()
        
        
    }
    
    func configure(){
        self.view.backgroundColor = .Main_BG
        self.headerLabel.textColor = .Gray_60
        self.headerLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        self.preventBtn.tintColor = .Main_10
        self.nextBtn.tintColor = .Main_10
        
        
        self.shadow.snp.makeConstraints{
            $0.top.equalTo(logoImageView.snp.bottom).offset(Constant.edgeHeight*(-8))
            $0.leading.trailing.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.height.equalTo(350)
        }
        
        self.backView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        self.headerLabel.snp.makeConstraints{
            $0.leading.equalTo(calendarView)
            $0.top.equalToSuperview().offset(Constant.edgeHeight*15)
        }
        
        self.nextBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(Constant.edgeWidth*26)
            $0.top.equalToSuperview().inset(Constant.edgeHeight*18)
            $0.height.width.equalTo(headerLabel.snp.height)
        }
        
        self.preventBtn.snp.makeConstraints{
            $0.trailing.equalTo(nextBtn.snp.leading).inset(Constant.edgeWidth*(-12))
            $0.centerY.equalTo(nextBtn)
            $0.height.width.equalTo(36)
        }
        self.weekMonthBtn.snp.makeConstraints{
            $0.trailing.equalTo(nextBtn.snp.leading).inset(Constant.edgeWidth*(-144))
            $0.centerY.equalTo(nextBtn)
            $0.height.width.equalTo(16)
        }
        
        self.calendarView.snp.makeConstraints{
            $0.height.equalTo(315)
            $0.left.right.equalToSuperview().inset(Constant.edgeWidth*12)
            $0.top.equalTo(headerLabel.snp.bottom).offset(Constant.edgeHeight*15)
            
        }
        
        
        self.logoImageView.snp.makeConstraints{
            $0.height.width.equalTo(104)
            $0.top.equalToSuperview().offset(Constant.edgeHeight*32)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*8)
        }
        
        self.optionBtn.snp.makeConstraints{
            $0.height.equalTo(104)
            $0.centerY.equalTo(logoImageView)
            $0.right.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        
        
        
       
    }
    
    @IBAction func preventBtnTapped(_ sender: Any) {
        scrollCurrentPage(isPrev: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        scrollCurrentPage(isPrev: false)
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
            
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }
}

extension HomeViewController : FSCalendarDelegate , FSCalendarDataSource, FSCalendarDelegateAppearance{
    func setCalendar() {
            calendarView.delegate = self
            calendarView.headerHeight = 0
            calendarView.scope = .month
            headerLabel.text = self.dateFormatter.string(from: calendarView.currentPage)
        }
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            self.headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
        }
    
}
