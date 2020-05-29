//
//  CategoryTableViewCell.swift
//  Dominos11_Starter
//
//  Created by 김광수 on 2020/05/29.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    var mainButton:UIButton = {
        var bt = UIButton()
        return bt
    }()
    
    var delegate: CategoryTableViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainButton.frame = CGRect(x: 0, y: 0, width: 380, height: 99)
        mainButton.addTarget(self, action: #selector(tabMainbutton(_:)), for: .touchUpInside)
        contentView.addSubview(mainButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tabMainbutton(_ sender:UIButton) {
        delegate?.tabMainButtonDelegate(self, row: sender.tag)
    }
}
