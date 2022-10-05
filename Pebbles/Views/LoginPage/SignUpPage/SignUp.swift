import UIKit
import SnapKit
import Then

class SignUp: UIViewController{
    
    var nickNameView = NicknameView()
    var futureView = UIView()
    
    public enum checkBtn {
        case next
        case complete
    }
    
    var check = checkBtn.next
    
    
    @IBOutlet weak var dissmissBtn: UIButton!
    
    @IBOutlet weak var nextCompleBtn: UIButton!
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        check = .next
    }
    
    func configure(){
        scrollView.contentSize.width = UIScreen.main.bounds.width * 2
        
        for i in 0..<2{
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            
            switch i {
            case 0:
                
                if let nickNameview = Bundle.main.loadNibNamed("NicknameView", owner: nil)?.first as? UIView {
                    
                    nickNameview.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height-appBar.bounds.height)
                    scrollView.addSubview(nickNameview)
                }
                
                break;
            default:
                futureView.frame = CGRect(x: xPosition, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height)
                scrollView.addSubview(futureView)
                break;
            }
        }
    }
    
//    private func setPageControl() {
//        pageController.numberOfPages = 2
//
//    }
//    private func setPageControlSelectedPage(currentPage:Int) {
//        pageController.currentPage = currentPage
//    }
    
    private func checkState(){
        switch check{
        case .next:
            print("현재 상태는 next에서 comp로 바뀌는 중")
            let compOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
            scrollView.setContentOffset(compOffset, animated: true)
            check = .complete
        case .complete:
            print("현재 상태는 comp에서 home으로 바뀌는 중")
            dismiss(animated: true)
        }
    }
    
    @IBAction func nextCompleBtnTapped(_ sender: Any) {
        checkState()
    }
    
    
    @IBAction func dissmissBtnTapped(_ sender: Any) {
        switch check{
        case .next:
            dismiss(animated: true)
        case .complete:
            scrollView.setContentOffset(.zero, animated: true)
            check = .next
        }
        
    }
    
    
    
    
}


