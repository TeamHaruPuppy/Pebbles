import UIKit

class BaseTabBarViewController : UITabBarController, UITabBarControllerDelegate{
    
    
    let homeViewContoller = HomeViewController()
    let pebbleManageViewContoller = PebbleManageViewController()
    let myStoneTowerViewContoller = MyStoneTowerViewController()

    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home", in: nil, with: Constant.configuration ),tag: 0)
    let pebbleManageTabBarItem = UITabBarItem(title: "바윗돌 관리", image: UIImage(named: "pebbleManagement", in: nil, with: Constant.configuration),tag: 1)
    let myStoneTowerTabBarItem = UITabBarItem(title: "내 돌탑", image: UIImage(named: "stoneTower", in: nil, with: Constant.configuration),tag: 2)
    
    override var selectedViewController: UIViewController? { // Mark 2
        didSet {
            
            guard let viewControllers = viewControllers else {
                return
            }
            
            for viewController in viewControllers {
                if viewController == selectedViewController {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12, weight: .bold)], for: .normal)
                } else {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12, weight: .regular)], for: .normal)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .Main_30
        let homeViewContoller = UINavigationController(rootViewController: homeViewContoller)
        let pebbleManageViewContoller = UINavigationController(rootViewController: pebbleManageViewContoller)
        let myStoneTowerViewContoller = UINavigationController(rootViewController: myStoneTowerViewContoller)
        self.tabBar.backgroundColor = .white
        
        homeViewContoller.tabBarItem = homeTabBarItem
        pebbleManageViewContoller.tabBarItem = pebbleManageTabBarItem
        myStoneTowerViewContoller.tabBarItem = myStoneTowerTabBarItem

        homeViewContoller.isNavigationBarHidden = true
        
        
        
        self.viewControllers = [homeViewContoller,pebbleManageViewContoller,myStoneTowerViewContoller]
        self.delegate = self
        
    }
}
