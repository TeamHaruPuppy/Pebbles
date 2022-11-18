import SnapKit
import UIKit

class HabitFooterTableViewCell: UITableViewHeaderFooterView {

    static let identifier = "HabitFooterTableViewCell"
    
    @IBOutlet weak var footerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setInit()
    }

    func setInit(){
        setConfigure()
        setAttribute()
    }
    
    func setConfigure(){
        
        footerView.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(Constant.edgeWidth*28)
        }
    }
    
    func setAttribute(){
        self.contentView.backgroundColor = .Main_BG
        footerView.backgroundColor = .White
        footerView.layer.masksToBounds = true
        footerView.layer.borderWidth = 0
        footerView.layer.cornerRadius = Constant.edgeHeight*14
        footerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
