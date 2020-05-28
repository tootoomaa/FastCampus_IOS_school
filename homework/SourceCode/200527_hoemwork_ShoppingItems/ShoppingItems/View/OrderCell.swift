//
//  OrderCell.swift
//  ShoppingItems
//
//  Created by 김광수 on 2020/05/27.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    

    var productImageView = UIImageView()
    var productNameLabel = UILabel()
    var productCountLabel = UILabel()
    
    var delegate: CustomCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        productImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        productNameLabel.frame = CGRect(x: 85, y: 10, width: 150, height: 40)
        productCountLabel.frame  = CGRect(x: 310, y: 25, width: 30, height: 30)
        
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(productCountLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
