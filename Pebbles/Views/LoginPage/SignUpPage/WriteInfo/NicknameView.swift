//
//  NicknameView.swift
//  Pebbles
//
//  Created by admin on 2022/10/05.
//

import UIKit

class NicknameView: UIView {
    
    let nicknameViewModel = WriteNickNameViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func repetCheckTapped(_ sender: Any) {
        
    }
    
}


