//
//  CustomCell.swift
//  homework_UITableview_delegate_200526
//
//  Created by 김광수 on 2020/05/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var plusButton = UIButton(type: .system)
    
    var delegate: CustomCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        plusButton.frame = CGRect(x: 250, y: 10, width: 100, height: 40)
        plusButton.setTitle("plus", for: .normal)
        plusButton.backgroundColor = .green
        plusButton.addTarget(self, action: #selector(tabplusButton(_:)), for: .touchUpInside)
        contentView.addSubview(plusButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tabplusButton(_ sender:UIButton) {
        let row = sender.tag
        delegate?.tabPlusButtonDelegate(self, buttonRow: row)
//        delegate?.printFunctionForTest()
    }
    
}
