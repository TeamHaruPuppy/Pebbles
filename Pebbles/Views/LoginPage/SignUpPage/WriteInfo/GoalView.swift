import SnapKit
import UIKit

class GoalView: UIView {

    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK: 커스텀한 뷰의 IBOutlet등의 초기화를 담당하는 함수 (ViewController의 ViewDidLoad와 같은 역할)
    override func awakeFromNib() {
        configure()
    }
    
    func configure(){
        mainTitleLabel.textColor = .Gray_60
        subTitleLabel.textColor = .Gray_50
        
        mainTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(Constant.edgeHeight*30)
            $0.left.equalToSuperview().inset(20)
        }
        
    }
}
