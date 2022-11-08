//
//  OptionViewController.swift
//  Pebbles
//
//  Created by admin on 2022/11/08.
//

import UIKit

class OptionViewController: UIViewController {

    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var separateView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAttribute()
        self.setConfigure()
       
    }


    func setConfigure(){
        
    }
    func setAttribute(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
