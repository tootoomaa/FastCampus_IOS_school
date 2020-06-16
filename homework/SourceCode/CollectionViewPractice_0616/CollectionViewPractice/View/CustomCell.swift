//
//  CustomCell.swift
//  CollectionViewPractice
//
//  Created by 김광수 on 2020/06/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.layer.cornerRadius = 10
    contentView.addSubview(imageView)
    imageView.frame = contentView.frame
    self.isMultipleTouchEnabled = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
