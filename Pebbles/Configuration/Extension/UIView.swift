import UIKit

extension UIView {
    func setViewShadow(backView: UIView) {
        
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.searchFieldBorderColor.cgColor
        
        backView.layer.masksToBounds = false
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = CGSize(width: 2, height: -2)
        backView.layer.shadowRadius = 4
    }
    
    func setViewRadius() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 4
        layer.borderWidth = 0
        layer.borderColor = UIColor.searchFieldBorderColor.cgColor
    }
}
