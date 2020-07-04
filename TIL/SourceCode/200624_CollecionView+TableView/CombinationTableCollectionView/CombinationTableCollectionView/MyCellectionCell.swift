//
//  MyCellectionCell.swift
//  CombinationTableCollectionView
//
//  Created by 김광수 on 2020/06/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class MyCellectionCell: UICollectionViewCell {
    static let identifier = "MyCollectionViewCell"
  
  var titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    titleLabel.textColor = .green
    titleLabel.textAlignment = .center
    titleLabel.font = .systemFont(ofSize: 50)
    
    contentView.addSubview(titleLabel)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
