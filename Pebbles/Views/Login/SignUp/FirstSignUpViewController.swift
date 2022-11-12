import SafariServices
import UIKit

class FirstSignUpViewController: UIViewController {
    
    
    

    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var goPageBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setConfi()
        // Do any additional setup after loading the view.
    }

    func setConfi(){
        self.view.backgroundColor = .White
        
        self.agreeBtn.isSelected = false
        self.nextBtn.isEnabled = false
        
        goPageBtn.layer.masksToBounds = true
        goPageBtn.layer.borderWidth = 0.5
        goPageBtn.layer.borderColor = UIColor.Gray_30.cgColor
        goPageBtn.layer.cornerRadius = 10
        
        
        nextBtn.backgroundColor = .Gray_30
        nextBtn.layer.masksToBounds = true
        nextBtn.layer.borderWidth = 0
        nextBtn.layer.cornerRadius = 10
    }
    @IBAction func agreeBtnTapped(_ sender: Any) {
        agreeBtn.isSelected.toggle()
        agreeBtn.tintColor = .Main_30
        if agreeBtn.isSelected == true{
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = .Main_30
        }
        else{
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .Gray_30
        }
    }
    
    @IBAction func goPageTapped(_ sender: Any) {
        let ctURL = NSURL(string: "https://olivine-shear-610.notion.site/951323d8e4054f1591136dc71e953ef8")
        let safariView: SFSafariViewController = SFSafariViewController(url: ctURL as! URL)
        self.present(safariView, animated: true, completion: nil)
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        print("나와")
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
