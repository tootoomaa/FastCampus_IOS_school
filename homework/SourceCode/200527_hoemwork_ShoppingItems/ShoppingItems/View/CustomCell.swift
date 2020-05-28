//
//  CustomCell.swift
//  ShoppingItems
//
//  Created by 김광수 on 2020/05/27.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell{
    
    var plusButton = UIButton(type: .contactAdd)
    var productImageView = UIImageView()
    var productNameLabel = UILabel()
    var productCountLabel = UILabel()
    
    var delegate: CustomCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        productImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        productNameLabel.frame = CGRect(x: 85, y: 10, width: 150, height: 40)
        productCountLabel.frame  = CGRect(x: 310, y: 25, width: 30, height: 30)
        plusButton.frame = CGRect(x: 320, y: 25, width: 60, height: 30)
        plusButton.addTarget(self, action: #selector(tabPlusButtonAction(_:)), for: .touchUpInside)
        
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(productCountLabel)
        contentView.addSubview(plusButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tabPlusButtonAction(_ sender:UIButton) {
        print(type(of: delegate))
        //cell을 넘기는 이유 : labelText를 변경하기 위해서
        // row를 통해서 데이터를 수정하고 tableview.reloaddata()
        delegate?.tabPlusButtonAction(self,row: sender.tag)
    }
    
}
