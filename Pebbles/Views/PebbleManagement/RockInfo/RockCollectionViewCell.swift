//
//  RockCollectionViewCell.swift
//  Pebbles
//
//  Created by admin on 2022/11/11.
//

import UIKit

class RockCollectionViewCell: UICollectionViewCell {

    static let identifier = "RockCollectionViewCell"
    
    @IBOutlet weak var fromStartToEndLabel: UILabel!
    @IBOutlet weak var rockTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setInit()
        // Initialization code
    }
    
    func setInit(){
        self.setConfigure()
        self.setAttribute()
    }
    func setConfigure(){
        fromStartToEndLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Constant.edgeHeight*15)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
        }
        
        rockTitleLabel.snp.makeConstraints{
            $0.top.equalTo(fromStartToEndLabel.snp.bottom).offset(Constant.edgeHeight*7)
            $0.left.equalToSuperview().inset(Constant.edgeWidth*20)
            $0.right.equalToSuperview().inset(Constant.edgeWidth*20)
        }
    }
    func setAttribute(){
        self.contentView.backgroundColor = .white
        contentView.layer.borderWidth = 0
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        fromStartToEndLabel.textColor = .Gray_50
        fromStartToEndLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        
        rockTitleLabel.textColor = .Gray_60
        rockTitleLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
    }
    
    func setData(start : String, end : String, title : String){
        self.fromStartToEndLabel.text = "\(start) ~ \(end)"
        self.rockTitleLabel.text = title
    }
    

}
