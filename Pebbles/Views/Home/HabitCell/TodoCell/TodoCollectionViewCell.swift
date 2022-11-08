import UIKit
import SnapKit
import Then


class TodoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TodoCollectionViewCell"
    var countSelect = 0
    var check = 0
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var todoCheckImg: UIImageView!
    @IBOutlet weak var todoCheckBtn: UIButton!
    @IBOutlet weak var separateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
        contentView.backgroundColor = .White
        // Initialization code
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
    }

    
    func setData(userData : Todo, index : Int){
        todoLabel.text = userData.name
        countSelect = index
    }

    
    @IBAction func todoCheckBtnTapped(_ sender: UIButton) {
        
        //MARK: 해당 투두가 활성화 된것을 체크 해주는 로직 필요
        
        sender.isSelected.toggle()
        if sender.isSelected == true{
            DispatchQueue.main.async {
                self.todoCheckImg.image = UIImage(named: "todoSelected.png")
            }
            check += 1
        }
        else{
            DispatchQueue.main.async {
                self.todoCheckImg.image = UIImage(named: "todoUnSelected.png")
                
            }
            check -= 1
        }
        
        if check == countSelect {
            // 델리게이트 사용해서 HabitCollectionViewCell에 넘겨줘서 HabitLabelBackgroundView 색 변경
        }
        else{
            // 델리게이트 사용해서 HabitCollectionViewCell에 넘겨줘서 HabitLabelBackgroundView 색 변경
        }
    }
}
