//
//  CustomCell.swift
//  homework_UITableView_200526
//
//  Created by 김광수 on 2020/05/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell{
    
    var plusButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
        plusButton.backgroundColor = .green
        plusButton.setTitle("Plus", for: .normal)
        plusButton.frame = CGRect(x: 250, y: 15, width: 60, height: 30)
        contentView.addSubview(plusButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
