import UIKit
import SnapKit



class AddPebblesViewController: UIViewController {
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tailView: UIView!
    
    
    @IBOutlet weak var rockTitleView: UIView!
    @IBOutlet weak var rockImg: UIImageView!
    @IBOutlet weak var rockTitleLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var headerSeparateView: UIView!
    
    @IBOutlet weak var habitAddBtn: UIButton!
    @IBOutlet weak var addImg: UIImageView!
    
    @IBOutlet weak var nextBtn: UIButton!
    private var HAVIT_CNT = 1
    var list : [ReqHabit] = []
    var checkStatus : [Bool] = [false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInit()
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    func setInit(){
        self.navigationController?.isNavigationBarHidden = true
        tableView.tableHeaderView = headerView
        tailView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: Constant.edgeHeight*150)
        tableView.tableFooterView = tailView
        
        
        
        self.setConfigure()
        self.setAttribute()
        self.registerXib()
        self.setDelegate()
        self.setAddTarget()
        
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
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
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
            $0.right.equalToSuperview().inset(Constant.edgeWidth*20)
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
        
        habitAddBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Device.width - Constant.edgeWidth*40)
            $0.height.equalTo(Constant.edgeHeight*40)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-Constant.edgeHeight*152)
        }
        
        addImg.snp.makeConstraints{
            $0.width.equalTo(Constant.edgeWidth*14)
            $0.height.equalTo(Constant.edgeHeight*14)
            $0.centerY.equalTo(habitAddBtn)
            $0.left.equalTo(habitAddBtn.snp.left).inset(Constant.edgeWidth*108)
        }
    }
    
    func setAttribute(){
        self.view.backgroundColor = .White
        tableView.backgroundColor = .White
        headerView.backgroundColor = .White
        tailView.backgroundColor = .White
        
        tableView.isScrollEnabled = false
        
        titleLabel.textColor = .Gray_60
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        
        rockTitleView.layer.masksToBounds = true
        rockTitleView.layer.borderWidth = 0
        rockTitleView.layer.cornerRadius = 10
        rockTitleView.backgroundColor = .Main_BG
        
        rockTitleLabel.textColor = .Main_50
        rockTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        
        introLabel.textColor = .Black
        introLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        headerSeparateView.backgroundColor = .Gray_10
        
        habitAddBtn.layer.masksToBounds = false
        habitAddBtn.layer.borderWidth = 0.5
        habitAddBtn.layer.borderColor = UIColor.Main_10.cgColor
        habitAddBtn.layer.cornerRadius = 8
        habitAddBtn.backgroundColor = .White
        habitAddBtn.titleLabel?.textAlignment = .center
        
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = .Gray_30
        nextBtn.tintColor = .White
        nextBtn.titleLabel?.textColor = .White
    }
    
    func registerXib(){
        let storyNib = UINib(nibName: AddPebbleTableViewCell.identifier, bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: AddPebbleTableViewCell.identifier)
    }
    
    func setDelegate(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func setAddTarget(){
        self.habitAddBtn.addTarget(self, action: #selector(moveAddHabit(_:)), for: .touchUpInside)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func habitAddBtnTapped(_ sender: Any) {
        
        //MARK: - IndexPath를 이용하여 원하는 위치로 스크롤 이동
        if HAVIT_CNT < 3 {
            self.HAVIT_CNT += 1
            self.tableView.insertRows(at: [IndexPath(row: HAVIT_CNT - 1, section: 0)], with: .bottom)
//            self.tableView.scrollToRow(at: IndexPath(row: HAVIT_CNT - 1, section: 0), at: .bottom, animated: true)
            tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.height), animated: true)
            
            //MARK: - 각 해빗의 입력 상태를 체크하는 스테이트 배열 추가작업
            checkStatus.append(false)
            falseEnter(false, HAVIT_CNT - 1)
        }
        
    }
    
    @objc func moveAddHabit(_ sender : UIButton){
        print("해빗 수: \(HAVIT_CNT)")
        if HAVIT_CNT == 1 {
            self.tableView.isScrollEnabled = false
            sender.snp.updateConstraints{
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-Constant.edgeHeight*152)
            }
        }
        else{
            self.tableView.isScrollEnabled = true
            sender.snp.updateConstraints{
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-Constant.edgeHeight*100)
            }
        }
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    
}

extension AddPebblesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HAVIT_CNT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddPebbleTableViewCell", for: indexPath) as? AddPebbleTableViewCell else {
            return UITableViewCell()
        }
        cell.viewController = self
        cell.deleteHabitBtn.tag = indexPath.row
        cell.delegate = self
        cell.deleteHabitBtn.addTarget(self, action:#selector(deleteHabit(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteHabit(_ sender: UIButton){
        self.HAVIT_CNT -= 1
        let point = sender.convert(CGPoint.zero, to: tableView) // 1
        guard let indexPath = tableView.indexPathForRow(at: point) else { return } // 2
        self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .bottom)
        self.tableView.scrollToRow(at: IndexPath(row: self.HAVIT_CNT - 1, section: 0), at: .bottom, animated: true)
//        deleteHabitIndex(HAVIT_CNT)
        
        if HAVIT_CNT == 1 {
            self.tableView.isScrollEnabled = false
            self.habitAddBtn.snp.updateConstraints{
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-Constant.edgeHeight*152)
            }
        }
        else{
            self.tableView.isScrollEnabled = true
            self.habitAddBtn.snp.updateConstraints{
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-Constant.edgeHeight*100)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.edgeHeight*351
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}


extension AddPebblesViewController : enterCompHabitDelegate {
    
    
    
    func deleteHabitIndex(_ index: Int) {
        print("index의 값 : \(index)")
        print("checkStatus의 상태 : \(checkStatus)")
        checkStatus.remove(at: index)
        
        for idx in checkStatus{
            if idx == false {
                nextBtn.isEnabled = false
                nextBtn.backgroundColor = .Gray_30
                return;
            }
        }
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = .Main_30
    }
    
    func trueEnter(_ T: Bool, _ index: Int) {
        checkStatus[index] = T
        for idx in checkStatus{
            if idx == false {return;}
        }
        print("checkStatus의 상태 : \(checkStatus)")
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = .Main_30
    }
    
    func falseEnter(_ F: Bool, _ index: Int) {
        checkStatus[index] = F
        print("checkStatus의 상태 : \(checkStatus)")
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = .Gray_30
    }
    
    
}
