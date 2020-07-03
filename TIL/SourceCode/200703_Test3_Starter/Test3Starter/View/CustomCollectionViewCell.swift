//
//  CustomCollectionViewCell.swift
//  Test3Starter
//
//  Created by 김광수 on 2020/07/03.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let identifier = "CustomCollectionViewCell"
  
  let pizzaImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "치킨퐁듀 그라탕")
    return imageView
  }()
  
  let pizzaNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Pizza name"
    label.font = .boldSystemFont(ofSize: 25)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  let pizzaPriceLabel: UILabel = {
    let label = UILabel()
    label.text = "5000원"
    label.font = .boldSystemFont(ofSize: 25)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .systemGray2
    
    [pizzaImageView, pizzaNameLabel, pizzaPriceLabel].forEach {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      pizzaImageView.topAnchor.constraint(equalTo: topAnchor),
      
      pizzaNameLabel.topAnchor.constraint(equalTo: pizzaImageView.bottomAnchor),
      pizzaNameLabel.heightAnchor.constraint(equalTo: pizzaImageView.heightAnchor, multiplier: 0.2),
      
      pizzaPriceLabel.topAnchor.constraint(equalTo: pizzaNameLabel.bottomAnchor),
      pizzaPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      pizzaPriceLabel.heightAnchor.constraint(equalTo: pizzaNameLabel.heightAnchor, multiplier: 1)
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
