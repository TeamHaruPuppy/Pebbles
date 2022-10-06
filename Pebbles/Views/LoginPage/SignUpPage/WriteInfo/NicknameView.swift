//
//  NicknameView.swift
//  Pebbles
//
//  Created by admin on 2022/10/05.
//

import UIKit

open class NicknameView: UIView, UITextFieldDelegate {
    
    let nicknameViewModel = WriteNickNameViewModel()
    
//    @IBOutlet weak var textField: UITextField!
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func repetCheckTapped(_ sender: Any) {
     print("중복확인")
    }
    
}


