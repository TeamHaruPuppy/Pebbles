import UIKit
import SnapKit
import Then
import RealmSwift
import FSCalendar
import UIWindowTransitions

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var habitTableView: UITableView!
    
    @IBOutlet weak var weekChangeImg: UIImageView!
    @IBOutlet weak var weekChangeBtn: UIButton!
    
    private var currOffsetY = 0.0
    private var touchEndOffsetY = 0.0
    private var showSelectData : [Habit] = []
    private var calendarHeight: NSLayoutConstraint?
    private var customView = UIView()
    private var currentPage: Date?
    
    private var findLastCell : [Int] = []
    private var checkStatus : [Int : Int] = [:]
    private var isToday = false
    private var isFirstVisit = false
    private var section = 0
    
    private var curDay = Date()
    
    
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
        self.initTodayData()
        
        optionBtn.addTarget(self, action: #selector(showOptionView), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calendarView.delegate = self
        calendarView.headerHeight = 50
        calendarView.scope = .month
        calendarHeight = calendarView.heightAnchor.constraint(equalToConstant: 300)
        calendarHeight?.isActive = true
        
        habitTableView.reloadData()
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
        let storyNib = UINib(nibName: HomeTodoTableViewCell.identifier, bundle: nil)
        habitTableView.register(storyNib, forCellReuseIdentifier: HomeTodoTableViewCell.identifier)
        
        let headerNib = UINib(nibName: HabitHeaderTableViewCell.identifier, bundle: nil)
        habitTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: HabitHeaderTableViewCell.identifier)
    }
    
    private func registerDelegate(){
        habitTableView.delegate = self
        habitTableView.dataSource = self
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
    }
    
    
    func configure(){
        self.view.backgroundColor = .Main_BG
        habitTableView.backgroundColor = .Main_BG
        weekChangeImg.tintColor = .Gray_40
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        
        
        
        //MARK: - 제약조건 설정
        self.logoImageView.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*64)
            $0.width.equalTo(Constant.edgeWidth*64)
            $0.top.equalToSuperview().offset(Constant.edgeHeight*44)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*8)
        }
        
        self.optionBtn.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*44)
            $0.centerY.equalTo(logoImageView)
            $0.right.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        self.optionImageView.snp.makeConstraints{
            $0.height.width.equalTo(Constant.edgeHeight*32)
            $0.centerY.centerX.equalTo(optionBtn)
        }
        
        
        self.shadow.snp.makeConstraints{
            $0.top.equalTo(logoImageView.snp.bottom).offset(Constant.edgeHeight*8)
            $0.leading.trailing.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.height.equalTo(calendarView.snp.height).offset(Constant.edgeHeight*40)
        }
        
        self.backView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        
        self.calendarView.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*350)
            $0.left.right.equalToSuperview().inset(Constant.edgeWidth*12)
            $0.top.equalToSuperview()
        }
        
        self.weekChangeBtn.snp.makeConstraints{
            $0.height.width.equalTo(Constant.edgeHeight*40)
            $0.top.equalTo(calendarView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        self.weekChangeImg.snp.makeConstraints{
            $0.width.height.equalTo(Constant.edgeWidth*20)
            $0.centerX.centerY.equalTo(weekChangeBtn)
        }
        
        
        
        self.habitTableView.snp.makeConstraints{
            $0.top.equalTo(backView.snp.bottom).offset(Constant.edgeHeight*20)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        
        
    }
    
    func initTodayData(){
        for idx in Constant.homeResult.habits{
            //MARK: - 오늘 날짜와 해빗이 나타나야하는 날짜가 같으면
            if Date().text == idx.today{
                //MARK: - 오늘의 요일과, 해빗의 요일이 같으면
                if idx.weeks.mon && (Date().onlyWeek == "Mon"){
                    Constant.TODAY_DATA.append(idx)
                }
                if idx.weeks.tue && (Date().onlyWeek == "Tue"){
                    Constant.TODAY_DATA.append(idx)
                }
                if idx.weeks.wed && (Date().onlyWeek == "Wed"){
                    Constant.TODAY_DATA.append(idx)
                }
                if idx.weeks.thu && (Date().onlyWeek == "Thu"){
                    Constant.TODAY_DATA.append(idx)
                }
                if idx.weeks.fri && (Date().onlyWeek == "Fri"){
                    Constant.TODAY_DATA.append(idx)
                }
                if idx.weeks.sat && (Date().onlyWeek == "Sat"){
                    Constant.TODAY_DATA.append(idx)
                }
                if idx.weeks.sun && (Date().onlyWeek == "Sun"){
                    Constant.TODAY_DATA.append(idx)
                }
            }
        }
        RealmManager().getRealm()
    }
    // 앱을 실행시키면 realm에서 데이터 가져오기 -> 앱을 종료시키면 realm에 데이터 저장하기
    // 근데 만약 어제 저장하고 종료하고 오늘 앱을 열면?
    
    
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




extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - 하나의 섹션에 들어갈 cell의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        guard let data = showSelectData else {return 0}
        return showSelectData[section].todos.count
    }
    
    //MARK: - 섹션의 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        //        guard let data = showSelectData else {return 0}
        return showSelectData.count
    }
    
    //MARK: - section의 헤더의 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.edgeHeight*58
    }
    
    
    //MARK: - cell의 정보
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTodoTableViewCell", for: indexPath) as? HomeTodoTableViewCell else {return UITableViewCell()}
        
        if isToday {
            cell.todoLabel.text = Constant.TODAY_DATA[indexPath.section].todos[indexPath.row].name
            if  Constant.TODAY_DATA[indexPath.section].todos[indexPath.row].status == "true" {
                checkStatus[indexPath.section] = checkStatus[indexPath.section]! - 1
                cell.todoCheckImg.image = UIImage(named: "todoSelected.png")
                cell.todoCheckBtn.isSelected = true
            }
            else{
                cell.todoCheckImg.image = UIImage(named: "todoUnSelected.png")
                cell.todoCheckBtn.isSelected = false
            }
            cell.todoCheckBtn.isEnabled = true
            cell.todoCheckBtn.tag = indexPath.section
            cell.todoCheckBtn.addTarget(self, action: #selector(changeStatus(_:)), for: .touchUpInside)
            return cell
        }
        else{
            cell.todoLabel.text = showSelectData[indexPath.section].todos[indexPath.row].name
            if showSelectData[indexPath.section].todos[indexPath.row].status == "true" {
                cell.todoCheckImg.image = UIImage(named: "todoSelected.png")
                cell.todoCheckBtn.isSelected = true
            }else{
                cell.todoCheckImg.image = UIImage(named: "todoUnSelected.png")
                cell.todoCheckBtn.isSelected = false
            }
            cell.todoCheckBtn.isEnabled = false
            return cell
        }
    }
    
    @objc func changeStatus(_ sender : UIButton){
        
        //MARK: - 선택한 곳을 기준으로 section과 row의 위치를 판별함
        let point = sender.convert(CGPoint.zero, to: habitTableView)    //1
        guard let indexPath = habitTableView.indexPathForRow(at: point) else { return } //2
        
        guard let cell = habitTableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? HomeTodoTableViewCell else {return;}
        guard let header = habitTableView.headerView(forSection: sender.tag) as? HabitHeaderTableViewCell else {return;}
        print("선택한 섹션의 번호 : \(indexPath.section)")
        
        //MARK: - 현재 상태를 local에 저장해뒀다가, status를 가져와서 반영 해줘야함
        cell.todoCheckBtn.isSelected.toggle()
        if cell.todoCheckBtn.isSelected {
            checkStatus[indexPath.section] = checkStatus[indexPath.section]! - 1
            DispatchQueue.main.async {
                cell.todoCheckImg.image = UIImage(named: "todoSelected.png")
                Constant.TODAY_DATA[indexPath.section].todos[indexPath.row].status = "true"
            }
        }
        else {
            checkStatus[indexPath.section] = checkStatus[indexPath.section]! + 1
            DispatchQueue.main.async {
                cell.todoCheckImg.image = UIImage(named: "todoUnSelected.png")
                Constant.TODAY_DATA[indexPath.section].todos[indexPath.row].status = "False"
            }
        }
        
        if checkStatus[indexPath.section] == 0 {
            Constant.TODAY_DATA[indexPath.section].todayStatus = "true"
            header.headerView.backgroundColor = .Main_10
            header.habitTitle.textColor = .White
        }else{
            Constant.TODAY_DATA[indexPath.section].todayStatus = "False"
            header.headerView.backgroundColor = .White
            header.habitTitle.textColor = .Black
        }
    }
    
    //MARK: - section의 헤더 정보
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HabitHeaderTableViewCell") as? HabitHeaderTableViewCell else {return UIView()}
        
        if isToday {
            header.habitTitle.text = Constant.TODAY_DATA[section].name
            if Constant.TODAY_DATA[section].todayStatus == "true"{
                header.headerView.backgroundColor = .Main_10
                header.habitTitle.textColor = .White
            }
            else{
                header.headerView.backgroundColor = .White
                header.habitTitle.textColor = .Black
            }
            return header
        }
        else{
            header.habitTitle.text = showSelectData[section].name
            if showSelectData[section].status == "true"{
                header.headerView.backgroundColor = .Main_10
                header.habitTitle.textColor = .White
            }
            else{
                header.headerView.backgroundColor = .White
                header.habitTitle.textColor = .Black
            }
            return header
        }
    }
    
    //MARK: - cell의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.edgeHeight*50
    }
    
    //MARK: - 스크롤 시작할 때 감지
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currOffsetY = scrollView.contentOffset.y
    }
    
    //MARK: - 스크롤 끝났을 때 감지
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
        touchEndOffsetY = habitTableView.contentOffset.y
    }
}



extension HomeViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    //MARK: - 주간, 월간 바뀔 때 자연스러운 애니메이션 부여
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool){
        calendarHeight?.constant = bounds.height
        self.view.layoutIfNeeded ()
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
    
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        if Date().text == date.text{
            isToday = true
        }else{
            isToday = false
        }
        
        showSelectData.removeAll()
        findLastCell.removeAll()
        checkStatus.removeAll()
        
        //MARK: - 진짜 오늘의 해빗인지, 과거 혹은 미래의 해빗인지 확인해서 버튼 비활성화 해야함
        
        for idx in Constant.homeResult.habits{
            //MARK: - 선택한 날짜와 해빗이 나타나야하는 날짜가 같으면
            if date.text == idx.today{
                //MARK: - 선택한 날의 요일과, 해빗의 요일이 같으면
                if idx.weeks.mon && (date.onlyWeek == "Mon"){
                    showSelectData.append(idx)
                }
                if idx.weeks.tue && (date.onlyWeek == "Tue"){
                    showSelectData.append(idx)
                }
                if idx.weeks.wed && (date.onlyWeek == "Wed"){
                    showSelectData.append(idx)
                }
                if idx.weeks.thu && (date.onlyWeek == "Thu"){
                    showSelectData.append(idx)
                }
                if idx.weeks.fri && (date.onlyWeek == "Fri"){
                    showSelectData.append(idx)
                }
                if idx.weeks.sat && (date.onlyWeek == "Sat"){
                    showSelectData.append(idx)
                }
                if idx.weeks.sun && (date.onlyWeek == "Sun"){
                    showSelectData.append(idx)
                }
            }
        }
        
        var section = 0
        for idx in showSelectData {
            checkStatus[section] = idx.todos.count
            findLastCell.append(idx.todos.count)
            section += 1
        }
        habitTableView.reloadData()
    }
    
}
