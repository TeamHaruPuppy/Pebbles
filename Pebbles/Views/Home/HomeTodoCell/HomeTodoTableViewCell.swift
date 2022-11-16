import SnapKit
import UIKit

class HomeTodoTableViewCell: UITableViewCell {

    static let identifier = "HomeTodoTableViewCell"
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var todoCheckImg: UIImageView!
    @IBOutlet weak var todoCheckBtn: UIButton!
    @IBOutlet weak var separateView: UIView!
    
    var section = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
        contentView.backgroundColor = .White
        backgroundView?.backgroundColor = .Main_BG
    }
    
    override func prepareForReuse() {
        self.configure()
        contentView.backgroundColor = .White
        backgroundView?.backgroundColor = .Main_BG
    }
    
    func configure(){
        separateView.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        todoLabel.snp.makeConstraints{
            $0.left.equalTo(separateView.snp.left)
            $0.centerY.equalToSuperview()
        }
        
        todoCheckBtn.snp.makeConstraints{
            $0.top.bottom.right.equalToSuperview()
            $0.width.equalTo(Constant.edgeWidth*60)
        }
        todoCheckImg.snp.makeConstraints{
            $0.right.equalTo(separateView.snp.right)
            $0.centerY.equalToSuperview()
        }
        
        todoLabel.backgroundColor = .white
        todoLabel.textColor = .Gray_60
        todoLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        separateView.backgroundColor = .Gray_20
        self.contentView.backgroundColor = .White
        self.backgroundView?.backgroundColor = .Main_BG
        self.inputView?.backgroundColor = .Main_BG
    }
    
}
