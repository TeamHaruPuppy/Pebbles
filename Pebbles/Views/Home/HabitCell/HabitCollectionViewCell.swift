import SnapKit
import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HabitCollectionViewCell"
    var todos : [Todo] = []
    var todoCount : Int = 0
    
    @IBOutlet weak var habitLabelBackgroundView: UIView!
    @IBOutlet weak var habitTitle: UILabel!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var todoList: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerXib()
        self.registerDelegate()
        self.configure()
        contentView.backgroundColor = .White
        
    }
    
    func configure(){
        self.contentView.backgroundColor = .white
        contentView.layer.borderWidth = 0
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        habitTitle.contentMode = .center
        habitTitle.textAlignment = .center
        separateView.backgroundColor = .Gray_20
        habitLabelBackgroundView.backgroundColor = .Main_10
        
        habitLabelBackgroundView.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.left.right.top.equalToSuperview()
        }
        habitTitle.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        separateView.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
            $0.top.equalTo(habitLabelBackgroundView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        todoList.snp.makeConstraints{
            $0.top.equalTo(separateView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
       
    }
    
    
    private func registerXib(){
        let storyNib = UINib(nibName: TodoCollectionViewCell.identifier, bundle: nil)
        todoList.register(storyNib, forCellWithReuseIdentifier: TodoCollectionViewCell.identifier)
    }
    
    private func registerDelegate(){
        todoList.delegate = self
        todoList.dataSource = self
    }
    
    func setData(userData : Habit, todoCount : Int){
        habitTitle.text = userData.name
        todos = userData.todos
        self.todoCount = todoCount
    }
}

extension HabitCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return todoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCollectionViewCell.identifier, for: indexPath) as? TodoCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(userData : todos[indexPath.row], index: todos.count)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 40
        return CGSize(width: width, height: 50)
    }
    
}
