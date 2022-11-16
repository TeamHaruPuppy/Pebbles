import SnapKit
import UIKit

class HabitHeaderTableViewCell: UITableViewHeaderFooterView  {

    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var habitTitle: UILabel!
    @IBOutlet weak var seperateView: UIView!
    
    static let identifier = "HabitHeaderTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setInit()
    }

    func setInit(){
        setConfigure()
        setAttribute()
    }
    
    func setConfigure(){
        headerView.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.left.right.top.equalToSuperview()
        }
        habitTitle.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        seperateView.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
    }
    
    func setAttribute(){
        self.contentView.backgroundColor = .white
        contentView.layer.borderWidth = 0
        contentView.layer.cornerRadius = 14
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        contentView.clipsToBounds = true
        
        habitTitle.contentMode = .center
        habitTitle.textAlignment = .center
        seperateView.backgroundColor = .Gray_20
        headerView.backgroundColor = .White
        habitTitle.textColor = .Gray_60
    }
}
