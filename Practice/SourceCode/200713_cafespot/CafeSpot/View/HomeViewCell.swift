
//
//  CollectionViewCell.swift
//  CafeSpot
//
//  Created by 김광수 on 2020/07/10.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let identifier = "HomeViewCell"
  
  var cafeData: CafeModel? {
    didSet {
      guard let cafeData = cafeData else { return }
      
      cafeName.text = cafeData.title
      cafeImageView.image = UIImage(named: cafeData.title)
      cafeImageView.layer.cornerRadius = 10
      cafeImageView.clipsToBounds = true
      cafeDiscription.text = cafeData.description
      heartCheckButton.isSelected = cafeData.isFavorite
      if cafeData.isFavorite == true {
        heartCheckButton.tintColor = .systemPink
      }
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
  
  lazy var heartCheckButton: UIButton = {
    let button = UIButton()
    
    let systemSymbolConf = UIImage.SymbolConfiguration(
      pointSize: 30,
      weight: .regular,
      scale: .medium
    )
    
    let emptyHeartImage = UIImage(systemName: "suit.heart",withConfiguration: systemSymbolConf)
    let fillHeartImage = UIImage(systemName: "suit.heart.fill",withConfiguration: systemSymbolConf)
    
    button.setImage(emptyHeartImage, for: .normal)
    button.setImage(fillHeartImage, for: .selected)
    
    button.tintColor = .white
    button.addTarget(self, action: #selector(tabHeartButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureUI()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    contentView.backgroundColor = .systemBackground
    
    [cafeImageView, cafeName, cafeDiscription].forEach{
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    addSubview(heartCheckButton)
    heartCheckButton.translatesAutoresizingMaskIntoConstraints = false
    heartCheckButton.frame.size = CGSize(width: 50, height: 50)
    
    NSLayoutConstraint.activate([
      
      cafeImageView.topAnchor.constraint(equalTo: topAnchor),
      
      cafeName.topAnchor.constraint(equalTo: cafeImageView.bottomAnchor),
      cafeName.heightAnchor.constraint(equalTo: cafeImageView.heightAnchor, multiplier: 0.2),
      
      cafeDiscription.topAnchor.constraint(equalTo: cafeName.bottomAnchor),
      cafeDiscription.bottomAnchor.constraint(equalTo: bottomAnchor),
      cafeDiscription.heightAnchor.constraint(equalTo: cafeName.heightAnchor, multiplier: 0.7),
      
      heartCheckButton.trailingAnchor.constraint(equalTo: cafeImageView.trailingAnchor),
      heartCheckButton.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor),
      heartCheckButton.widthAnchor.constraint(equalToConstant: 40),
      heartCheckButton.heightAnchor.constraint(equalToConstant: 40)
    ])
  }

  // MARK: - Handler
  
  @objc func tabHeartButton(_ sender: UIButton) {
    sender.isSelected.toggle()
    if sender.isSelected == true {
      sender.tintColor = .systemPink
    } else {
      sender.tintColor = .white
    }
  }
  
  @objc func handleTapImage(_ sender: Any) {
    
    print("tap image")
    
  }
}
