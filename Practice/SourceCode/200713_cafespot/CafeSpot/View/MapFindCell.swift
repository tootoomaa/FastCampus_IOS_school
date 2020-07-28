//
//  MapFindCell.swift
//  CafeSpot
//
//  Created by 김광수 on 2020/07/13.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class MapFindCell: UICollectionViewCell {
    
  // MARK: - Properties
  static let identifier = "MapFindCell"
  
  var myAnnotation: MyAnnotation? {
    didSet {
      guard let myAnnotation = myAnnotation else { return }
      
      cafeImageView.image = UIImage(named: myAnnotation.cafeName)
      cafeName.text = myAnnotation.cafeName
      cafeDiscription.text = myAnnotation.detailInfo
      
    }
  }
  
  var cafeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "감성다방")
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  let cafeName: UILabel = {
    let label = UILabel()
    label.text = "CafeName.."
    label.textColor = .black
    label.font = .systemFont(ofSize: 20)
    return label
  }()
  
  let cafeDiscription: UILabel = {
    let label = UILabel()
    label.text = "This Cafe is Nice.."
    label.textColor = .systemGray2
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.backgroundColor = .systemBackground
    
    configureUI()
    
    
  }
  
  func configureUI() {
    contentView.backgroundColor = .systemBackground
    
    [cafeImageView, cafeName, cafeDiscription].forEach{
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      
      cafeImageView.topAnchor.constraint(equalTo: topAnchor),
      
      cafeName.topAnchor.constraint(equalTo: cafeImageView.bottomAnchor),
      cafeName.heightAnchor.constraint(equalTo: cafeImageView.heightAnchor, multiplier: 0.2),
      
      cafeDiscription.topAnchor.constraint(equalTo: cafeName.bottomAnchor),
      cafeDiscription.bottomAnchor.constraint(equalTo: bottomAnchor),
      cafeDiscription.heightAnchor.constraint(equalTo: cafeName.heightAnchor, multiplier: 0.7),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
