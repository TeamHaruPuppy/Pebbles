import UIKit

class BaseTabBarViewController : UITabBarController, UITabBarControllerDelegate{
    
    
//    let workViewController = WorkViewController()
//    let classViewController = ClassViewController()
//    let searchViewController = SearchViewController()
//    let categoryViewController = CategoryViewController()
//    let myInfoViewController = MyInfoViewController()
//
//    let workTabBarItem = UITabBarItem(title: "작품", image: UIImage(named: "Work", in: nil, with: Constant.configuration),tag: 0)
//    let classTabBarItem = UITabBarItem(title: "클래스", image: UIImage(named: "Class", in: nil, with: Constant.configuration),tag: 1)
//    let searchTabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "Search", in: nil, with: Constant.configuration),tag: 2)
//    let categoryTabBarItem = UITabBarItem(title: "카테고리", image: UIImage(named: "Category", in: nil, with: Constant.configuration),tag: 3)
//    let myinfoTabBarItem = UITabBarItem(title: "내 정보", image: UIImage(named: "MyInfo", in: nil, with: Constant.configuration),tag: 4)
    
    override var selectedViewController: UIViewController? { // Mark 2
        didSet {
            
            guard let viewControllers = viewControllers else {
                return
            }
            
            for viewController in viewControllers {
                if viewController == selectedViewController {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10, weight: .bold)], for: .normal)
                } else {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10, weight: .regular)], for: .normal)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBar.tintColor = UIColor.mainOrange
//        let workNetworkController = UINavigationController(rootViewController: workViewController)
//        let classNetworkController = UINavigationController(rootViewController: classViewController)
//        let searchNetworkController = UINavigationController(rootViewController: searchViewController)
//        let categoryNetworkController = UINavigationController(rootViewController: categoryViewController)
//        let myInfoNetworkController = UINavigationController(rootViewController: myInfoViewController)
//
//        workNetworkController.tabBarItem = workTabBarItem
//        classNetworkController.tabBarItem = classTabBarItem
//        searchNetworkController.tabBarItem = searchTabBarItem
//        categoryNetworkController.tabBarItem = categoryTabBarItem
//        myInfoNetworkController.tabBarItem = myinfoTabBarItem
//
//        self.viewControllers = [workNetworkController,classNetworkController,searchNetworkController,categoryNetworkController,myInfoNetworkController]
        self.delegate = self
        
    }
}
