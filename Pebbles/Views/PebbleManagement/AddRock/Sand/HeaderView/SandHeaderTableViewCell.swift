import SnapKit
import UIKit

class SandHeaderTableViewCell: UITableViewHeaderFooterView {

    
    @IBOutlet weak var pebbleTitleView: UIView!
    @IBOutlet weak var pebbleImg: UIImageView!
    @IBOutlet weak var pebbleTitleLabel: UILabel!
    
    @IBOutlet weak var pebbleNameLabel: UILabel!
    
    @IBOutlet weak var seperateView: UIView!
    
    static let identifier = "SandHeaderTableViewCell"
    
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
    }
    
    func setConfigure(){
        seperateView.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(Constant.edgeHeight*7)
        }
        
        pebbleTitleView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(Constant.edgeWidth*20)
            $0.width.equalTo(Device.width - (Constant.edgeWidth*40))
            $0.height.equalTo(Constant.edgeHeight*48)
            $0.top.equalTo(seperateView.snp.bottom).offset(Constant.edgeHeight*20)
        }
        
        pebbleImg.snp.makeConstraints{
            $0.height.equalTo(Constant.edgeHeight*28)
            $0.width.equalTo(Constant.edgeWidth*28)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(Constant.edgeWidth*10)
        }
        
        pebbleTitleLabel.snp.makeConstraints{
            $0.left.equalTo(pebbleImg.snp.right).inset(-Constant.edgeWidth*8)
            $0.centerY.equalToSuperview()
        }
        
        pebbleNameLabel.snp.makeConstraints{
            $0.top.equalTo(pebbleTitleView.snp.bottom).offset(Constant.edgeHeight*20)
            $0.left.equalToSuperview().inset(Constant.edgeHeight*20)
        }
    }
    
    func setAttribute(){
        self.contentView.backgroundColor = .White
        self.seperateView.backgroundColor = .Gray_10
        
        pebbleTitleView.layer.masksToBounds = true
        pebbleTitleView.layer.borderWidth = 0
        pebbleTitleView.layer.cornerRadius = 10
        pebbleTitleView.backgroundColor = .Gray_10
        
        pebbleTitleLabel.textColor = .Gray_50
        pebbleTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        
    }
    
}
