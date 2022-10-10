import SnapKit
import UIKit

class GoalView: UIView {

    weak var delegate : ChangeBtnDelegate?
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!

    
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
        textView.delegate = self
        
        mainTitleLabel.textColor = .Gray_60
        subTitleLabel.textColor = .Gray_50
        
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 15
        textView.layer.borderColor = UIColor.Gray_30.cgColor
        textView.backgroundColor = .clear
        textView.text = "예시) 베스트셀러 작가, 매년 1억 버는 사람, 사람 다운 사람 등 자유롭게 적어보세요"
        textView.textColor = .Gray_30
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        
        mainTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(Constant.edgeHeight*30)
            $0.left.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(Constant.edgeHeight*8)
            $0.left.equalToSuperview().inset(20)
        }
        
        textView.snp.makeConstraints{
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(Constant.edgeHeight*25)
            $0.left.right.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.height.equalTo(Constant.edgeHeight*195)
        }
    }
}


extension GoalView : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "예시) 베스트셀러 작가, 매년 1억 버는 사람, 사람 다운 사람 등 자유롭게 적어보세요" {
            textView.text = nil
            textView.textColor = .black
        }else{
            textView.layer.borderColor = UIColor.Main_30.cgColor
            self.delegate?.isNextBtnEnabled()
            
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "예시) 베스트셀러 작가, 매년 1억 버는 사람, 사람 다운 사람 등 자유롭게 적어보세요"
            textView.textColor = .Gray_30
        }
    }
}
