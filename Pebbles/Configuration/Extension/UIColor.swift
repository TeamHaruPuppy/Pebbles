//
//  UIColor.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var Black: UIColor { UIColor(hex: 0x494F56) }
    class var Gray_60: UIColor { UIColor(hex: 0x494F56) }
    class var Gray_50: UIColor { UIColor(hex: 0x5D687A) }
    class var Gray_40: UIColor { UIColor(hex: 0x919BAB) }
    class var Gray_30: UIColor { UIColor(hex: 0xCBD0D7) }
    class var Gray_20: UIColor { UIColor(hex: 0xE8EAED) }
    class var Gray_10: UIColor { UIColor(hex: 0xF4F5F7) }
    class var White: UIColor { UIColor(hex: 0xFFFFFF) }
    class var alart: UIColor {UIColor(hex: 0xF94A4A) }
    class var Main_30: UIColor {UIColor(hex: 0x35A3FF) }
    class var Main_20: UIColor {UIColor(hex: 0x5CB4FF) }
    class var Main_10: UIColor {UIColor(hex: 0x82C6FF) }
    
    
}
