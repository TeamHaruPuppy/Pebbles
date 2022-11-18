import SnapKit
import UIKit

class AddSandViewController: UIViewController {

    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    
    @IBOutlet weak var rockTitleView: UIView!
    @IBOutlet weak var rockImg: UIImageView!
    @IBOutlet weak var rockTitleLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var headerSeparateView: UIView!

    @IBOutlet weak var nextBtn: UIButton!
    
    private var SECTION_ZERO_TODO_COUNT = 0
    private var SECTION_ONE_TODO_COUNT = 0
    private var SECTION_TWO_TODO_COUNT = 0
    
    private var textFieldIsTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInit()
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setInit(){
        
        self.navigationController?.isNavigationBarHidden = true
        tableView.tableHeaderView = headerView
        
        
        self.setConfigure()
        self.setAttribute()
        self.registerXib()
        self.setDelegate()
        self.setAddTarget()
        self.setKeyboardObserver()
        
    }
    
    func setConfigure(){
        appBar.snp.makeConstraints{
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(Constant.edgeHeight*56)
        }
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints{
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Constant.edgeWidth*32)
            $0.height.equalTo(Constant.edgeHeight*32)
        }
        
        backImg.snp.makeConstraints{
            $0.center.equalTo(backBtn)
            $0.height.width.equalTo(Constant.edgeHeight*24)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(appBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(nextBtn.snp.top)
        }
        
        headerView.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*165)
            $0.width.equalTo(Device.width)
        }
        
        
        rockTitleView.snp.makeConstraints{
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.width.equalTo(Device.width - (Constant.edgeWidth*40))
            $0.height.equalTo(Constant.edgeHeight*48)
            $0.top.equalToSuperview().inset(Constant.edgeHeight*17)
        }
        
        rockImg.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*28)
            $0.width.equalTo(Constant.edgeWidth*28)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(Constant.edgeWidth*10)
        }
        
        rockTitleLabel.snp.makeConstraints{
            $0.left.equalTo(rockImg.snp.right).inset(-Constant.edgeWidth*8)
            $0.centerY.equalToSuperview()
        }
        
        introLabel.snp.makeConstraints{
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.top.equalTo(rockTitleView.snp.bottom).offset(Constant.edgeHeight*20)
        }
        
        headerSeparateView.snp.makeConstraints{
            $0.top.equalTo(introLabel.snp.bottom).offset(Constant.edgeHeight*20)
            $0.height.equalTo(Constant.edgeHeight*7)
            $0.left.right.bottom.equalToSuperview()
        }
        
        nextBtn.snp.makeConstraints{
            $0.bottom.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(Constant.edgeHeight*50)
        }
    }
    
    func setAttribute(){
        self.view.backgroundColor = .White
        tableView.backgroundColor = .White
        headerView.backgroundColor = .White
        
        tableView.isScrollEnabled = true
        
        titleLabel.textColor = .Gray_60
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        
        rockTitleView.layer.masksToBounds = true
        rockTitleView.layer.borderWidth = 0
        rockTitleView.layer.cornerRadius = 10
        rockTitleView.backgroundColor = .Main_BG
        
        rockTitleLabel.textColor = .Main_50
        rockTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        rockTitleLabel.text = Constant.POST_HIGHLIGHT.name
        
        introLabel.textColor = .Black
        introLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        headerSeparateView.backgroundColor = .Gray_10
        
//        nextBtn.isEnabled = false
//        nextBtn.backgroundColor = .Gray_30
//        nextBtn.tintColor = .White
//        nextBtn.titleLabel?.textColor = .White
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = .Main_30
        nextBtn.tintColor = .White
        nextBtn.titleLabel?.textColor = .White
        
//        for section in 0..<Constant.POST_HIGHLIGHT.habits.count{
//
//            for idx in 0..<3{
//                Constant.POST_HIGHLIGHT.habits[section].todos.append(ReqTodo(seq: idx))
//                print("투두 저장하는 즁 : [\(section) : \(idx)]")
//            }
//        }
        
    }
    
    func registerXib(){
//        let storyNib = UINib(nibName: AddSandTableViewCell.identifier, bundle: nil)
//        tableView.register(storyNib, forCellReuseIdentifier: AddSandTableViewCell.identifier)
        let sandTextNib = UINib(nibName: TextFieldTableViewCell.identifier, bundle: nil)
        tableView.register(sandTextNib, forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        
        let headerNib = UINib(nibName: SandHeaderTableViewCell.identifier, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: SandHeaderTableViewCell.identifier)
        
        let footerNib = UINib(nibName: SandFooterTableViewCell.identifier, bundle: nil)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: SandFooterTableViewCell.identifier)
    }
    
    func setDelegate(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setAddTarget(){
        nextBtn.addTarget(self, action: #selector(postData(_:)), for: .touchUpInside)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        for section in 0..<Constant.POST_HIGHLIGHT.habits.count{
            Constant.POST_HIGHLIGHT.habits[section].todos.removeAll()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func postData(_ sender : UIButton){
        self.checkTodoInEmpty()
        
        PostHighlightDataManager().postHighlight(Constant.POST_HIGHLIGHT, self) { data in
            Constant.POST_HIGHLIGHT_RES = data
            GetHomeDataManager().getHome(self) { data in
                Constant.homeResult = data
                for idx in Constant.homeResult.habits{
                    if idx.today == Date().text {
                        let endIndex = Constant.TODAY_DATA.endIndex
                        if  Constant.TODAY_DATA.isEmpty {
                        }
                        else if idx.id > Constant.TODAY_DATA[endIndex - 1].id{
                            Constant.TODAY_DATA.append(idx)
                        }
                    }
                }
                print("Constant.TODAY_DATA에 있는 값 전부 들고와봐 : \(Constant.TODAY_DATA)")
                GetRockInfoDataManager().getRockInfo(self) { data in
                    Constant.rockResult = data
                    guard let pvc = self.presentingViewController else { return }
                    pvc.viewWillAppear(true)
                    self.dismiss(animated: true)
                }
            }
        }
        
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
    }

    
    func checkTodoInEmpty(){
        var index = 0
        for idx in Constant.POST_HIGHLIGHT.habits{
            if idx.todos.count == 0 {
                Constant.POST_HIGHLIGHT.habits[index].todos.append(ReqTodo(name: "\(idx.name)", seq: 0))
            }
            index += 1
        }
        
        for idx in Constant.POST_HIGHLIGHT.habits{
            print("[\(idx.name)]의 투두는 : \(idx.todos)")
        }
        
    }
    
}

extension AddSandViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return SECTION_ZERO_TODO_COUNT
        }
        else if section == 1 {
            
            return SECTION_ONE_TODO_COUNT
        }
        else {
            return SECTION_TWO_TODO_COUNT
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constant.POST_HIGHLIGHT.habits.count
    }
    
    //MARK: - section의 header관련
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.edgeHeight*118
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SandHeaderTableViewCell") as? SandHeaderTableViewCell else {return UIView()}
        header.pebbleTitleLabel.text = Constant.POST_HIGHLIGHT.habits[section].name
        return header
    }
    
    
    //MARK: - section의 footer관련
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return Constant.edgeHeight*80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SandFooterTableViewCell") as? SandFooterTableViewCell else {return UIView()}
        footer.todoAddBtn.addTarget(self, action: #selector(addTodo(_:)), for: .touchUpInside)
        footer.todoAddBtn.tag = section
        return footer
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as? TextFieldTableViewCell else {
            return UITableViewCell()
        }
        cell.textField.tag = indexPath.row
        cell.SECTION = indexPath.section
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.edgeHeight*60
    }
   
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    @objc func addTodo(_ sender : UIButton){
        print("세부 할 일 추가하기 클릭했습니다")
        
        if sender.tag == 0{
            SECTION_ZERO_TODO_COUNT += 1
            self.tableView.insertRows(at: [IndexPath(row: SECTION_ZERO_TODO_COUNT - 1, section: sender.tag)], with: .bottom)
            self.tableView.scrollToRow(at: IndexPath(row: SECTION_ZERO_TODO_COUNT - 1, section: sender.tag), at: .bottom, animated: true)
        }else if sender.tag == 1 {
            SECTION_ONE_TODO_COUNT += 1
            self.tableView.insertRows(at: [IndexPath(row: SECTION_ONE_TODO_COUNT - 1, section: sender.tag)], with: .bottom)
            self.tableView.scrollToRow(at: IndexPath(row: SECTION_ONE_TODO_COUNT - 1, section: sender.tag), at: .bottom, animated: true)
        }else {
            SECTION_TWO_TODO_COUNT += 1
            self.tableView.insertRows(at: [IndexPath(row: SECTION_TWO_TODO_COUNT - 1, section: sender.tag)], with: .bottom)
            self.tableView.scrollToRow(at: IndexPath(row: SECTION_TWO_TODO_COUNT - 1, section: sender.tag), at: .bottom, animated: true)
        }
    }
    
}

extension AddSandViewController  {
    func setKeyboardObserver() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
        }
        
        @objc func keyboardWillShow(notification: NSNotification) {
            
            
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                    UIView.animate(withDuration: 1) {
                        self.view.window?.frame.origin.y = -keyboardHeight
                    }
                }
          }
        
        @objc func keyboardWillHide(notification: NSNotification) {
            if self.view.window?.frame.origin.y != 0 {
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                        let keyboardRectangle = keyboardFrame.cgRectValue
                        let keyboardHeight = keyboardRectangle.height
                    UIView.animate(withDuration: 1) {
                        self.view.window?.frame.origin.y = 0
                    }
                }
            }
        }
}


extension AddSandViewController : saveTodoDelegate {
    func saveTodo(_ sender: UITextField) {
        //MARK: - 선택한 곳을 기준으로 section과 row의 위치를 판별함
        let point = sender.convert(CGPoint.zero, to: tableView)    //1
        guard let indexPath = tableView.indexPathForRow(at: point) else { return } //2
        
        if indexPath.section == 0 {
            Constant.POST_HIGHLIGHT.habits[indexPath.section].todos.append(ReqTodo(name: sender.text, seq: SECTION_ZERO_TODO_COUNT - 1))
        }
        else if indexPath.section == 1{
            Constant.POST_HIGHLIGHT.habits[indexPath.section].todos.append(ReqTodo(name: sender.text, seq: SECTION_ONE_TODO_COUNT - 1))
        }
        else {
            Constant.POST_HIGHLIGHT.habits[indexPath.section].todos.append(ReqTodo(name: sender.text, seq: SECTION_TWO_TODO_COUNT - 2))
        }

        
    }
}
