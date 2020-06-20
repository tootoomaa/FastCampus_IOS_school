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
  
  let checkView: UIImageView = {
    let chview = UIImageView()
    
    let defaultImage = UIImage(systemName: "pencil")!
    let whiteImage = defaultImage.withTintColor(.white)
    
    chview.image = UIImage(systemName: "checkmark.circle.fill")
    chview.isHidden = true
    return chview
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.layer.cornerRadius = 20
    contentView.clipsToBounds = true
    
    contentView.addSubview(imageView)
    imageView.frame = contentView.frame
    
    contentView.addSubview(checkView)
    let checkWidth = imageView.frame.size.width/3
    checkView.frame = CGRect(x: checkWidth*2 ,y: checkWidth*2, width: checkWidth, height: checkWidth)
    
    self.isMultipleTouchEnabled = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
