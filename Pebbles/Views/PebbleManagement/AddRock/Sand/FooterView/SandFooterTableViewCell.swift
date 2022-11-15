import SnapKit
import UIKit

class SandFooterTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var todoAddBtn: UIButton!
    @IBOutlet weak var separateView: UIView!
    
    var todoCount = 0
    
    static let identifier = "SandFooterTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setInit()
    }

    func setInit(){
        self.setConfigure()
        self.setAttribute()
        self.setAddTarget()
    }
    
    func setConfigure(){
        todoAddBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Device.width - Constant.edgeWidth*40)
            $0.height.equalTo(Constant.edgeHeight*40)
            $0.top.equalToSuperview().offset(Constant.edgeHeight*20)
        }
    }
    
    func setAttribute(){
        self.contentView.backgroundColor = .White
        todoAddBtn.layer.masksToBounds = false
        todoAddBtn.layer.borderWidth = 0.5
        todoAddBtn.layer.borderColor = UIColor.Main_10.cgColor
        todoAddBtn.layer.cornerRadius = 8
        todoAddBtn.backgroundColor = .White
        
    }
    
    func setAddTarget(){
        todoAddBtn.addTarget(self, action: #selector(addTodo(_:)), for: .touchUpInside)
    }
    
    @objc func addTodo(_ sender : UIButton){
        print("세부 할 일 추가하기 클릭했습니다")
        
//        pebbleNameTableView.snp.updateConstraints{
//            $0.height.equalTo(self.todoCount * (Int(Constant.edgeHeight)*60))
//        }
//        if let delegate = delegate {
//                    delegate.updateHabitViewHeight(self, pebbleNameTableView)
//        }
//        pebbleNameTableView.reloadData()
    }
}
