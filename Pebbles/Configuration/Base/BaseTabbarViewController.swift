import UIKit

class BaseTabBarViewController : UITabBarController, UITabBarControllerDelegate{
    
    
    let homeViewContoller = HomeViewController()
    let pebbleManageViewContoller = PebbleManageViewController()
    let myStoneTowerViewContoller = MyStoneTowerViewController()
    
    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeActiveX.png", in: nil, with: Constant.configuration ),selectedImage: UIImage(named: "homeActive.png", in: nil, with: Constant.configuration))
    let pebbleManageTabBarItem = UITabBarItem(title: "바윗돌 관리", image: UIImage(named: "manageActiveX.png", in: nil, with: Constant.configuration),selectedImage: UIImage(named: "manageActive.png", in: nil, with: Constant.configuration))
//    let myStoneTowerTabBarItem = UITabBarItem(title: "내 돌탑", image: UIImage(named: "stoneTowerX.png", in: nil, with: Constant.configuration),selectedImage: UIImage(named: "stoneTower.png", in: nil, with: Constant.configuration))
    
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
//        let myStoneTowerViewContoller = UINavigationController(rootViewController: myStoneTowerViewContoller)
        self.tabBar.backgroundColor = .white
        
        homeViewContoller.tabBarItem = homeTabBarItem
        pebbleManageViewContoller.tabBarItem = pebbleManageTabBarItem
//        myStoneTowerViewContoller.tabBarItem = myStoneTowerTabBarItem
        
        homeViewContoller.isNavigationBarHidden = true
        pebbleManageViewContoller.isNavigationBarHidden = true
        
        //MARK: - iOS 15.0 업데이트 이후에는, scroll영역이 tabbar 하단까지 이어질 경우 tabber의 색을 따로 지정 해줘여함
        // 참조 : https://stackoverflow.com/questions/67899805/ios-15-tab-bar-transparent-after-scrolling-to-the-bottom
        UITabBar.appearance().barTintColor = .White
        UITabBar.appearance().isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .White
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
        
        
        self.viewControllers = [homeViewContoller,pebbleManageViewContoller]
        self.delegate = self
        
    }
}
