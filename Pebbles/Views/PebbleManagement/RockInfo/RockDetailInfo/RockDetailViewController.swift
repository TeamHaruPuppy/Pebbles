import UIKit
import SnapKit


class RockDetailViewController: UIViewController {
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var rockTitleLabel: UILabel!
    @IBOutlet weak var startStackView: UIStackView!
    @IBOutlet weak var endStackView: UIStackView!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var startDayLabel: UILabel!
    @IBOutlet weak var endDayLabel: UILabel!
    @IBOutlet weak var startDayValue: UILabel!
    @IBOutlet weak var endDayValue: UILabel!
    @IBOutlet weak var graphImg: UIImageView!
    
    @IBOutlet weak var seperateView: UIView!
    
    
//    //MARK: - 데이터 전달 받아올 변수들
//    var rockName : String?
//    var start : String?
//    var end : String?
    var habitCnt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("여기 나왔냐??")
        self.setInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func setInit(){
        self.navigationController?.isNavigationBarHidden = true
        tableView.tableHeaderView = headerView
        
        self.setAttribute()
        self.setConfigure()
        self.registerXib()
        self.setDelegate()
        self.tableView.reloadData()
    }
    
    func setConfigure(){
        appBar.snp.makeConstraints{
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(Constant.edgeHeight*56)
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
            $0.left.right.bottom.equalToSuperview()
            $0.width.equalTo(Device.width)
        }
        
        headerView.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*150)
            $0.width.equalTo(Device.width)
        }
        
        rockTitleLabel.snp.makeConstraints{
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.top.equalToSuperview().offset(Constant.edgeHeight*14)
        }
        
        verticalStackView.snp.makeConstraints{
            $0.top.equalTo(rockTitleLabel.snp.bottom).offset(Constant.edgeHeight*24)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
        }

        graphImg.snp.makeConstraints{
            $0.width.equalTo(Constant.edgeWidth*64)
            $0.height.equalTo(Constant.edgeHeight*64)
            $0.right.equalToSuperview().inset(Constant.edgeWidth*16)
            $0.top.equalTo(rockTitleLabel.snp.bottom).offset(Constant.edgeHeight*13)
        }
        
        
        seperateView.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.height.equalTo(Constant.edgeHeight*14)
            $0.width.equalToSuperview()
        }
        
    }
    
    func setAttribute(){
        self.view.backgroundColor = .White
        tableView.backgroundColor = .White
        headerView.backgroundColor = .White
        
        rockTitleLabel.textColor = .Black
        rockTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        startDayLabel.textColor = .Gray_40
        startDayLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)

        endDayLabel.textColor = .Gray_40
        endDayLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)

        startDayValue.textColor = .Gray_60
        startDayValue.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)

        endDayValue.textColor = .Gray_60
        endDayValue.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)

        graphImg.contentMode = .scaleAspectFill
        
        seperateView.backgroundColor = .Gray_10
    }
    
    func registerXib(){
        let storyNib = UINib(nibName: PebbleDetailCollectionViewCell.identifier, bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: PebbleDetailCollectionViewCell.identifier)
    }
    
    func setDelegate(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setHeaderData(_ RockName : String, _ startValue : String, _ endValue : String, _ habitCnt : Int){
        self.rockTitleLabel.text = RockName
        self.startDayValue.text = startValue
        self.endDayValue.text = endValue
        self.habitCnt = habitCnt
    }
}

extension RockDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // habit의 개수 + 헤더 뷰
        return self.habitCnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddPebbleTableViewCell") as? AddPebbleTableViewCell else {
            return UITableViewCell()
        }
        cell.viewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.edgeHeight*400
    }
    
}

