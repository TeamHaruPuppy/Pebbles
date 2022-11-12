import UIKit
import SnapKit



class PebbleManageViewController: UIViewController {
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var mainLogo: UIImageView!
    
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addImg: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInit()
        
    }
    func setInit(){
        self.setAttribute()
        self.setConfigure()
        self.registerXib()
        self.setDelegate()
    }
    func setConfigure(){
        
        self.appBar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(Constant.edgeHeight*56)
        }
        
        self.mainLogo.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Constant.edgeWidth*56)
            $0.height.equalTo(Constant.edgeHeight*56)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        self.collectionView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(appBar.snp.bottom)
            $0.width.equalTo(Device.width)
        }
        
        self.addBtn.snp.makeConstraints{
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(100)
            $0.height.width.equalTo(80)
        }
        
        self.addImg.snp.makeConstraints{
            $0.centerX.centerY.equalTo(addBtn)
            $0.width.equalTo(Constant.edgeWidth*80)
            $0.height.equalTo(Constant.edgeHeight*80)
        }
        
    }
    func setAttribute(){
        self.view.backgroundColor = .Main_BG
        self.appBar.backgroundColor = .Main_BG
        self.collectionView.backgroundColor = .Main_BG
        
        addBtn.backgroundColor = .clear
        addBtn.titleLabel?.text = ""
        addImg.layer.masksToBounds = true
        addImg.contentMode = .scaleToFill
    }
    func registerXib(){
        let storyNib = UINib(nibName: RockCollectionViewCell.identifier, bundle: nil)
        collectionView.register(storyNib, forCellWithReuseIdentifier: RockCollectionViewCell.identifier)
    }
    func setDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    @IBAction func addBtnTapped(_ sender: Any) {
        let rootVC = AddRockViewController()
        let rootViewController = UINavigationController(rootViewController: rootVC)
        
        rootViewController.modalPresentationStyle = .fullScreen
        self.present(rootViewController, animated: true)
    }
}

extension PebbleManageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.rockResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RockCollectionViewCell.identifier, for: indexPath) as? RockCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(start: Constant.rockResult[indexPath.row].start, end: Constant.rockResult[indexPath.row].end, title: Constant.rockResult[indexPath.row].name)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        flow.sectionInset = UIEdgeInsets(top: Constant.edgeHeight*10, left: Constant.edgeWidth*20, bottom: 0, right: Constant.edgeWidth*20)
        let width = Device.width - Constant.edgeWidth*40
        
        return CGSize(width: width, height: Constant.edgeHeight*72)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GetHighlightDetailInfoDataManager().getHighlightDetailInfo(self, Constant.rockResult[indexPath.row].id) { data in
            Constant.rockDetailResult = data
            let vc = RockDetailViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true) {
                vc.setHeaderData(data.name, data.start, data.end)
            }
        }
    }
    
}
