//
//  TextFieldTableViewCell.swift
//  Pebbles
//
//  Created by admin on 2022/11/16.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    static let identifier = "TextFieldTableViewCell"
    var SECTION = 0
    //MARK: - tag => indexPath.row
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setInit()
        textField.delegate = self
    }
    
    override func prepareForReuse() {
        self.setInit()
    }

    func setInit(){
        self.setConfigure()
        self.setAttribute()
    }
    
    func setConfigure(){
        textField.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.height.equalTo(Constant.edgeHeight*50)
        }
    }
    
    func setAttribute(){
        self.contentView.backgroundColor = .White
        self.backgroundView?.backgroundColor = .White
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.Gray_30.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.text = ""
        textField.placeholder = "하루에 할 일을 적어주세요!"
        textField.setPlaceholderColor(.Gray_30)
        textField.backgroundColor = .White
        textField.textColor = .Black
    }
}

extension TextFieldTableViewCell : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Constant.POST_HIGHLIGHT.habits[self.SECTION].todos[self.textField.tag].name = textField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
