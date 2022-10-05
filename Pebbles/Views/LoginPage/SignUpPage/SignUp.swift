import UIKit
import SnapKit
import Then

class SignUp: UIViewController{
    
    var nickNameView = NicknameView()
    var futureView = UIView()
    
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    func configure(){
        scrollView.contentSize.width = UIScreen.main.bounds.width * 2
        
        for i in 0..<2{
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            
            switch i {
            case 0:
                nickNameView.frame = CGRect(x: xPosition, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height)
                
                if let nickNameview = Bundle.main.loadNibNamed("NicknameView", owner: nil)?.first as? UIView {
                    nickNameview.frame = self.view.bounds
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
    
    
    
    
    
}
