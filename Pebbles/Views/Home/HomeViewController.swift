import UIKit
import SnapKit
import Then
import FSCalendar
import UIWindowTransitions

class HomeViewController: UIViewController {
    
    struct TodayHabit {
        // todoCount => 해빗을 달성하기 위해 필요한 todo의 수 | habits => 오늘 해야하는 habit들
        var todoCount : [Int] = []
        var habits : [Habit] = []
        init(){
            for idx in Constant.homeResult.habits {
                if Constant.selectDay == "Mon" && idx.weeks.mon {habits.append(idx); todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Tue" && idx.weeks.tue {habits.append(idx); todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Wed" && idx.weeks.wed {habits.append(idx); todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Thu" && idx.weeks.thu {habits.append(idx); todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Fri" && idx.weeks.fri {habits.append(idx); todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Sat" && idx.weeks.sat {habits.append(idx); todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Sun" && idx.weeks.sun {habits.append(idx); todoCount.append(idx.todos.count)}
            }
        }
    }
    
    
    
    @IBOutlet weak var habitCollectionView: UICollectionView!
    
    @IBOutlet weak var weekChangeImg: UIImageView!
    @IBOutlet weak var weekChangeBtn: UIButton!
    @IBOutlet weak var addHabitBtn: UIButton!
    @IBOutlet weak var addHabitImg: UIImageView!
    
    private var currOffsetY = 0.0
    private var touchEndOffsetY = 0.0
    private var todayHabit = TodayHabit()
    private var calendarHeight: NSLayoutConstraint?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(logoImageView)
        self.view.addSubview(optionBtn)
        self.view.addSubview(optionImageView)
        self.view.addSubview(shadow)
        self.shadow.addSubview(backView)
        self.backView.addSubview(weekChangeBtn)
        self.backView.addSubview(weekChangeImg)
        self.backView.addSubview(calendarView)
        self.registerXib()
        self.registerDelegate()
        self.configure()
        
        calendarView.tag = 1
        habitCollectionView.tag = 2
        
        optionBtn.addTarget(self, action: #selector(showOptionView), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calendarView.delegate = self
        calendarView.headerHeight = 50
        calendarView.scope = .month
        calendarHeight = calendarView.heightAnchor.constraint(equalToConstant: 300)
        calendarHeight?.isActive = true
        
    }
    
    
    private let logoImageView = UIImageView().then{
        $0.image = UIImage(named: "mainLogo_color.png")!
        $0.contentMode = .scaleAspectFill
    }
    
    private let optionImageView = UIImageView().then{
        $0.image = UIImage(named: "option.png")!
        $0.contentMode = .scaleAspectFill
    }
    
    private let optionBtn = UIButton().then{
        $0.tintColor = .clear
        $0.backgroundColor = .clear
    }
    
    
    private var calendarView = FSCalendar().then{
        $0.backgroundColor = .white
        $0.appearance.titleDefaultColor = .Gray_30
        $0.appearance.titleWeekendColor = .Gray_30
        $0.appearance.headerTitleColor = .Gray_60
        $0.appearance.weekdayTextColor = .Gray_60
        $0.appearance.titleTodayColor = .Gray_50
        $0.appearance.titlePlaceholderColor = .Gray_10
        $0.appearance.headerTitleFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.appearance.weekdayFont = UIFont(name :"AppleSDGothicNeo-Medium", size: 13)
        $0.appearance.titleFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.appearance.selectionColor = .Main_10
        
        $0.appearance.headerTitleColor = .Gray_60
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerTitleAlignment = .center
        $0.appearance.borderRadius = 14
        $0.clipsToBounds = true
        $0.appearance.headerDateFormat = "YYYY년 MM월"
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
        
        habitCollectionView.backgroundColor = .Main_BG
        
        weekChangeImg.tintColor = .Gray_40
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        addHabitBtn.backgroundColor = .clear
        addHabitBtn.titleLabel?.text = ""
        addHabitImg.layer.masksToBounds = true
        addHabitImg.contentMode = .scaleToFill
        
        
        
        //MARK: - 제약조건 설정
        self.logoImageView.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*64)
            $0.width.equalTo(Constant.edgeWidth*64)
            $0.top.equalToSuperview().offset(Constant.edgeHeight*44)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*8)
        }
        
        self.optionBtn.snp.makeConstraints{
            $0.height.equalTo(44)
            $0.centerY.equalTo(logoImageView)
            $0.right.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        self.optionImageView.snp.makeConstraints{
            $0.height.width.equalTo(32)
            $0.centerY.centerX.equalTo(optionBtn)
        }
        
        
        self.shadow.snp.makeConstraints{
            $0.top.equalTo(logoImageView.snp.bottom).offset(Constant.edgeHeight*8)
            $0.leading.trailing.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.height.equalTo(calendarView.snp.height).offset(40)
        }
        
        self.backView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        
        self.calendarView.snp.makeConstraints{
            $0.height.equalTo(350)
            $0.left.right.equalToSuperview().inset(Constant.edgeWidth*12)
            $0.top.equalToSuperview()
        }
        
        self.weekChangeBtn.snp.makeConstraints{
            $0.height.width.equalTo(40)
            $0.top.equalTo(calendarView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        self.weekChangeImg.snp.makeConstraints{
            $0.width.height.equalTo(20)
            $0.centerX.centerY.equalTo(weekChangeBtn)
        }
        
        
        
        self.habitCollectionView.snp.makeConstraints{
            $0.top.equalTo(backView.snp.bottom).offset(20)
            $0.left.right.bottom.equalToSuperview()
        }
        
        self.addHabitBtn.snp.makeConstraints{
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.width.equalTo(80)
        }
        
        self.addHabitImg.snp.makeConstraints{
            $0.centerX.centerY.equalTo(addHabitBtn)
            $0.width.equalTo(Constant.edgeWidth*80)
            $0.height.equalTo(Constant.edgeHeight*80)
        }
        
    }
    
    
    @IBAction func weekMonthBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected == true{
            self.calendarView.setScope(.week, animated: true)
            DispatchQueue.main.async {
                self.weekChangeImg.image = UIImage(systemName: "chevron.down")
            }
        }
        else{
            self.calendarView.setScope(.month, animated: true)
            DispatchQueue.main.async {
                self.weekChangeImg.image = UIImage(systemName: "chevron.up")
                
            }
        }
    }
    
    
    @IBAction func addHabitBtnTapped(_ sender: Any) {
        let rootVC = AddRockViewController()
        let rootViewController = UINavigationController(rootViewController: rootVC)
        
        rootViewController.modalPresentationStyle = .fullScreen
        self.present(rootViewController, animated: true)
        
    }
    
    @objc func showOptionView(){
        let pushVC = OptionViewController()
        let viewController = UINavigationController(rootViewController: pushVC)
        viewController.isNavigationBarHidden = true
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true)
    }
    
    
    func changeBar(hidden:Bool){
        guard let tabBar = self.tabBarController?.tabBar else {
            return;
        }
        // 탭바가 사라져 있다면 애니메이션(사라지는)효과를 주지 않음
        if tabBar.isHidden == hidden{
            return;
        }
        let frame = tabBar.frame;
        let offset = hidden ? (frame.size.height) : -(frame.size.height)
        let duration:TimeInterval = 0.5
        tabBar.isHidden = false;
        UIView.animate(withDuration: duration, animations: {
            ()-> Void in
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: {(isTrue) -> Void in
            if isTrue{
                tabBar.isHidden = hidden;
            }
        });
        
        
    }
    
}


extension HomeViewController : FSCalendarDelegate , FSCalendarDataSource, FSCalendarDelegateAppearance{
    
    
    //MARK: - 주간, 월간 바뀔 때 자연스러운 애니메이션 부여
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool){
        calendarHeight?.constant = bounds.height
        self.view.layoutIfNeeded ()
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        Constant.selectDay = date.onlyWeek
        Constant.selectFullDay = date.text
        let today = Date()
        todayHabit.habits.removeAll()
        todayHabit.todoCount.removeAll()
        print("오늘 날짜 : \(today.text) vs 선택한 날짜 : \(date.text)")
        if date.text != today.text{
            for idx in Constant.homeResult.habits {
                if Constant.selectDay == "Mon" && idx.weeks.mon {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
                if Constant.selectDay == "Tue" && idx.weeks.tue {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
                if Constant.selectDay == "Wed" && idx.weeks.wed {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
                if Constant.selectDay == "Thu" && idx.weeks.thu {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
                if Constant.selectDay == "Fri" && idx.weeks.fri {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
                if Constant.selectDay == "Sat" && idx.weeks.sat {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
                if Constant.selectDay == "Sun" && idx.weeks.sun {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
            }
        }
        else{
            for idx in Constant.homeResult.habits {
                if Constant.selectDay == "Mon" && idx.weeks.mon {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Tue" && idx.weeks.tue {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Wed" && idx.weeks.wed {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Thu" && idx.weeks.thu {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Fri" && idx.weeks.fri {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Sat" && idx.weeks.sat {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
                if Constant.selectDay == "Sun" && idx.weeks.sun {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
            }
        }
        print("----------------------------------------")
        print("선택한 날은 \(date.onlyWeek)요일 입니다")
        print("오늘의 데이터는 : \(todayHabit.habits)")
        print("----------------------------------------")
        habitCollectionView.reloadData()
    }
    
    //MARK: - 각 날짜의 테두리 둥글기 조절(radius)
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 15
    }
    
    //MARK: - 각 날짜의 테두리 색상 조절
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        
        let baseMonth = calendar.currentPage.onlyMonthText
        let currMonth = date.onlyMonthText
        let findToday = Date().text
        let today = date.text
        
        if findToday == today {
            return .Gray_50
        }
        
        if baseMonth == currMonth {
            return .Gray_30
        }
        else{
            return .Gray_10
        }
    }
    
    //MARK: - 각 날짜의 내부 채우기 색상 조절
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        let baseMonth = calendar.currentPage.onlyMonthText
        let currMonth = date.onlyMonthText
        
        if baseMonth == currMonth {
            return .White
        }
        else{
            return .Gray_10
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendar.reloadData()
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
        cell.setData(userData : todayHabit.habits[indexPath.row], todoCount: todayHabit.todoCount[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        flow.minimumLineSpacing = 20
        flow.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        let width = UIScreen.main.bounds.width - 40
//        let countHeight = Float(todayHabit.habits[indexPath.row].todos.count)
        let countHeight = Float(todayHabit.todoCount[indexPath.row])
        
//        let today = Date()
//        todayHabit.habits.removeAll()
//        todayHabit.todoCount.removeAll()
//        if Constant.selectFullDay != today.text{
//            for idx in Constant.homeResult.habits {
//                if Constant.selectDay == "Mon" && idx.weeks.mon {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
//                if Constant.selectDay == "Tue" && idx.weeks.tue {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
//                if Constant.selectDay == "Wed" && idx.weeks.wed {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
//                if Constant.selectDay == "Thu" && idx.weeks.thu {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
//                if Constant.selectDay == "Fri" && idx.weeks.fri {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
//                if Constant.selectDay == "Sat" && idx.weeks.sat {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
//                if Constant.selectDay == "Sun" && idx.weeks.sun {todayHabit.habits.append(idx); todayHabit.todoCount.append(0)}
//            }
//        }
//        else{
//            for idx in Constant.homeResult.habits {
//                if Constant.selectDay == "Mon" && idx.weeks.mon {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
//                if Constant.selectDay == "Tue" && idx.weeks.tue {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
//                if Constant.selectDay == "Wed" && idx.weeks.wed {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
//                if Constant.selectDay == "Thu" && idx.weeks.thu {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
//                if Constant.selectDay == "Fri" && idx.weeks.fri {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
//                if Constant.selectDay == "Sat" && idx.weeks.sat {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
//                if Constant.selectDay == "Sun" && idx.weeks.sun {todayHabit.habits.append(idx); todayHabit.todoCount.append(idx.todos.count)}
//            }
//        }
        
        return CGSize(width: width, height: 50*CGFloat(countHeight) + 50 )
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        touchEndOffsetY = scrollView.contentOffset.y
        //        print("스크롤 끝난 오프셋 : \(touchEndOffsetY)")
        
        if touchEndOffsetY > currOffsetY, currOffsetY >= 0{
            if weekChangeBtn.isSelected == false{
                self.calendarView.setScope(.week, animated: true)
                DispatchQueue.main.async {
                    self.weekChangeImg.image = UIImage(systemName: "chevron.down")
                }
                weekChangeBtn.isSelected.toggle()
            }
            changeBar(hidden: true)
            //            print("hidden값 : true")
        }else if touchEndOffsetY < currOffsetY{
            changeBar(hidden: false)
            //            print("hidden값 : false")
        }
    }
}

extension HomeViewController {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchEndOffsetY = habitCollectionView.contentOffset.y
    }
}
