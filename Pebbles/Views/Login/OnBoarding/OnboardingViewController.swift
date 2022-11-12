//
//  OnboardingViewController.swift
//  Pebbles
//
//  Created by admin on 2022/11/09.
//

import UIKit

let images = [ "ios_onboarding 1.png", "ios_onboarding 2.png", "ios_onboarding 3.png"]
class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFit
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .Gray_30
        pageControl.currentPageIndicatorTintColor = .Main_30
        imageView.image = UIImage(named: images[0])
        
        nextBtn.layer.masksToBounds = true
        nextBtn.layer.borderWidth = 0
        nextBtn.layer.cornerRadius = 10
        
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = .Main_30
    }
    
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if pageControl.currentPage != 2 {
            pageControl.currentPage += 1
            DispatchQueue.main.async {
                self.imageView.image = UIImage(named: images[self.pageControl.currentPage])
            }
        }
        else{
            guard let pvc = self.presentingViewController else { return }
            self.dismiss(animated: true) {
                let viewController = UINavigationController(rootViewController: FirstSignUpViewController())
                viewController.modalPresentationStyle = .fullScreen
                pvc.present(viewController, animated: true)
            }
        }
    }
}
