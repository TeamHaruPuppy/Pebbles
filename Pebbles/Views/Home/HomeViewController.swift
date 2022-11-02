import UIKit
import SnapKit
import Then
import FSCalendar

class HomeViewController: UIViewController {
    
    struct TodayHabit {
        // todoCount => 해빗을 달성하기 위해 필요한 todo의 수 | habits => 오늘 해야하는 habit들
        var todoCount : [Int] = []
        var habits : [Habit] = []
        init(){
            for idx in Constant.homeResult.habits {
                if idx.today == Constant.homeResult.today{
                    habits.append(idx)
                    todoCount.append(idx.todos.count)
                }
            }
        }
    }
    
    
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var weekMonthBtn: UIButton!
    @IBOutlet weak var preventBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var habitCollectionView: UICollectionView!
    
    private var todayHabit = TodayHabit()
    private var calendarHeight: NSLayoutConstraint?
    private var weekMonthCheck = false
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
        calendarView.delegate = self
        calendarView.headerHeight = 0
        calendarView.scope = .month
        calendarHeight = calendarView.heightAnchor.constraint(equalToConstant: 300)
        calendarHeight?.isActive = true
        headerLabel.text = self.dateFormatter.string(from: calendarView.currentPage)
        
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
        $0.appearance.titleDefaultColor = .Gray_30
        $0.appearance.titleWeekendColor = .Gray_30
        $0.appearance.headerTitleColor = .Gray_60
        $0.appearance.weekdayTextColor = .Gray_60
        $0.appearance.todayColor = .Main_BG
        $0.appearance.titleTodayColor = .Gray_50
        $0.appearance.titlePlaceholderColor = .Gray_10
        $0.appearance.selectionColor = .Main_10
        //        $0.placeholderType = .none
        
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
    
        self.view.addSubview(logoImageView)
        self.view.addSubview(optionBtn)
        self.view.addSubview(shadow)
        self.shadow.addSubview(backView)
        self.backView.addSubview(headerLabel)
        self.backView.addSubview(weekMonthBtn)
        self.backView.addSubview(nextBtn)
        self.backView.addSubview(preventBtn)
        self.backView.addSubview(calendarView)
        self.registerXib()
        self.registerDelegate()
        self.configure()
        
        calendarView.tag = 1
        habitCollectionView.tag = 2
        
    }
    
    private func registerXib(){
        let storyNib = UINib(nibName: HabitCollectionViewCell.identifier, bundle: nil)
        habitCollectionView.register(storyNib, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
    }
    
    private func registerDelegate(){
        habitCollectionView.delegate = self
        habitCollectionView.dataSource = self
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    
    func configure(){
        self.view.backgroundColor = .Main_BG
        self.headerLabel.textColor = .Gray_60
        self.headerLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        self.preventBtn.tintColor = .Main_10
        self.nextBtn.tintColor = .Main_10
        habitCollectionView.backgroundColor = .Main_BG
        
        
        self.shadow.snp.makeConstraints{
            $0.top.equalTo(logoImageView.snp.bottom).offset(Constant.edgeHeight*(-8))
            $0.leading.trailing.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.height.equalTo(calendarView.snp.height).offset(50)
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
            $0.height.equalTo(300)
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
        
        self.habitCollectionView.snp.makeConstraints{
            $0.top.equalTo(calendarView.snp.bottom).offset(20)
            $0.left.right.bottom.equalToSuperview()
        }
        

    }
    
    @IBAction func weekMonthBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected == true{
            self.calendarView.setScope(.week, animated: true)
            
        }
        else{
            self.calendarView.setScope(.month, animated: true)
        }
        
//
//        if weekMonthCheck == true {
//            self.calendarView.setScope(.month, animated: true)
//            weekMonthCheck = false
//        }else{
//            self.calendarView.setScope(.week, animated: true)
//            weekMonthCheck = true
//        }
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
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool){
        
        calendarHeight?.constant = bounds.height
        self.view.layoutIfNeeded ()
    }
    
    
    //MARK: 해빗의 성취도에 따라서 날짜별로 색을 칠해주는 코드
    //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
    //
    //
    //        if thisDay.first != nil {
    //                    guard let fillDay = thisDay.first else { return UIColor.clear }
    //
    //                    switch fillDay.achievement {
    //                    case "A":
    //                        return UIColor.achievementColor(.A)
    //                    case "B":
    //                        return UIColor.achievementColor(.B)
    //                    case "C":
    //                        return UIColor.achievementColor(.C)
    //                    case "D":
    //                        return UIColor.achievementColor(.D)
    //                    case "E":
    //                        return UIColor.achievementColor(.E)
    //                    default:
    //                        return UIColor.clear
    //                    }
    //                }else{
    //                    return UIColor.clear
    //                }
    //    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        let imageDateFormatter = DateFormatter()
        let todayDateFormatter = DateFormatter()
        imageDateFormatter.dateFormat = "yyyyMMdd"
        todayDateFormatter.dateFormat = "yyyyMMdd"
        var dateStr = imageDateFormatter.string(from: date)
        var todayDateStr = todayDateFormatter.string(from: Date())
        let startIdx = dateStr.index(dateStr.startIndex, offsetBy: 4)
        let monthStartIdx = calendar.currentPage.toString().index(calendar.currentPage.toString().startIndex, offsetBy: 5)
        let endIdx = dateStr.index(dateStr.startIndex, offsetBy: 6)
        let monthEndIdx = calendar.currentPage.toString().index(calendar.currentPage.toString().startIndex, offsetBy: 7)
        var sliced_str = dateStr[startIdx ..< endIdx]
        var sliced_monthSrt = calendar.currentPage.toString()[monthStartIdx ..< monthEndIdx]
        
        if sliced_str == sliced_monthSrt {
            return .Gray_20
        }
        else if today == imageDateFormatter.date(from: date.text){
            return .Gray_50
        }
        return .Gray_10
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 15
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
        return .Main_10
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        calendar.currentPage
        
        
        let imageDateFormatter = DateFormatter()
        let todayDateFormatter = DateFormatter()
        imageDateFormatter.dateFormat = "yyyyMMdd"
        
        //        if calendar.appearance.
        todayDateFormatter.dateFormat = "yyyyMMdd"
        var dateStr = imageDateFormatter.string(from: date)
        var todayDateStr = todayDateFormatter.string(from: Date())
        let startIdx = dateStr.index(dateStr.startIndex, offsetBy: 4)
        let monthStartIdx = calendar.currentPage.toString().index(calendar.currentPage.toString().startIndex, offsetBy: 5)
        let endIdx = dateStr.index(dateStr.startIndex, offsetBy: 6)
        let monthEndIdx = calendar.currentPage.toString().index(calendar.currentPage.toString().startIndex, offsetBy: 7)
        var sliced_str = dateStr[startIdx ..< endIdx]
        var sliced_monthSrt = calendar.currentPage.toString()[monthStartIdx ..< monthEndIdx]
        
//        print("자른 요일이야 ~~ \(sliced_monthSrt)")
        if sliced_str == sliced_monthSrt {
            return .white
        }
        return .Gray_10
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return 1
        }
        return todayHabit.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(userData : todayHabit.habits[indexPath.row])
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        flow.minimumLineSpacing = 20
        flow.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        let width = UIScreen.main.bounds.width - 40
        let countHeight = Float(todayHabit.habits[indexPath.row].todos.count)
        print("[\(indexPath.row)번째 투두의 개수] : \(todayHabit.habits[indexPath.row].todos.count)")
        return CGSize(width: width, height: 50*CGFloat(countHeight) + 50 )
    }
    
    
    
}
