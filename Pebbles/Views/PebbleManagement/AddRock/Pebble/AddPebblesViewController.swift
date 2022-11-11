import UIKit
import SnapKit

class AddPebblesViewController: UIViewController {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInit()
    }
    
    func setInit(){
        self.navigationController?.isNavigationBarHidden = true
        tableView.tableHeaderView = headerView
        
        self.setConfigure()
        self.setAttribute()
        self.registerXib()
        self.setDelegate()
        self.tableView.reloadData()
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
            $0.left.right.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*165)
            $0.width.equalTo(self.view.bounds.width)
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
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func setAttribute(){
        self.view.backgroundColor = .White
        tableView.backgroundColor = .White
        headerView.backgroundColor = .White
        
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
    }
    
    func registerXib(){
        let storyNib = UINib(nibName: AddPebbleTableViewCell.identifier, bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: AddPebbleTableViewCell.identifier)
    }
    
    func setDelegate(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddPebblesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // habit의 개수 + 헤더 뷰
        return Constant.HABIT_COUNT
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

