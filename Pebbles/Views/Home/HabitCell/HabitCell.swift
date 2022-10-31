import SnapKit
import UIKit
import Then
import Kingfisher

class HabitCell: UICollectionViewCell {
    static let id = "HabitCell"
    
    // MARK: UI
    private var habitCollectionView = UICollectionView()
    
    // MARK: Initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.contentView.addSubview(self.imageView)
//        self.contentView.addSubview(self.label)
//        self.imageView.snp.makeConstraints {
//            $0.top.left.right.equalToSuperview()
//            $0.bottom.equalToSuperview().inset(36)
//        }
//        self.label.snp.makeConstraints {
//            $0.top.equalTo(self.imageView.snp.bottom)
//            $0.left.right.bottom.equalToSuperview()
//        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        self.prepare(image: "", name: "")
    }
    
    func prepare(image: String, name: String) {
        
//        self.label.text = name
    }
}

