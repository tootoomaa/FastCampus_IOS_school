//
//  CustomTableViewCell.swift
//  Test3Starter
//
//  Created by 김광수 on 2020/07/03.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

  // MARK: - Properties
  
  static let identifier = "CustomTableViewCell"
  
  var menuDetailDataArray: [[String:Any]]! {
    didSet {
      collectionView.reloadData()
    }
  }
  
  var offset: CGPoint {
    // set(value)
    set {
      collectionView.contentOffset = newValue
      print(newValue)
    }
    get {
      collectionView.contentOffset
    }
  }
  
  var categoryImageString: String? {
    didSet {
      guard let imageName = categoryImageString else { return }
      categoryImageView.image = UIImage(named: imageName)
    }
  }
  
  struct Standard {
    static let padding: CGFloat = 20
    static let myInset: UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20)
  }
  
  let categoryImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "치킨퐁듀 그라탕")
    return imageView
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .white
    
    configureCollectionView()
    
    configureAutoLayout()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCollectionView() {
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(
      CustomCollectionViewCell.self,
      forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
    )
  }
  
  func configureAutoLayout() {
    
    [categoryImageView, collectionView].forEach {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      categoryImageView.topAnchor.constraint(equalTo: topAnchor),
      
      collectionView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      collectionView.heightAnchor.constraint(equalTo: categoryImageView.heightAnchor, multiplier: 5)
    ])
  }
}

// MARK: - UICollevtionViewDataSource
extension CustomTableViewCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return menuDetailDataArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CustomCollectionViewCell.identifier,
      for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
    
    let pizzaDataArray = menuDetailDataArray[indexPath.row]
    
    guard let pizzaName = pizzaDataArray["품명"] as? String,
      let pizzaPrice = pizzaDataArray["가격"] as? Int else { return UICollectionViewCell() }
    
    
    cell.pizzaImageView.image = UIImage(named: pizzaName)
    cell.pizzaNameLabel.text = pizzaName
    cell.pizzaPriceLabel.text = "\(pizzaPrice) 원"
    
    return cell
  }
  
}

// MARK: - UICollectionVeiwDelegateFlowLayout
extension CustomTableViewCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Standard.padding
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Standard.myInset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let myWidth = contentView.frame.width - Standard.myInset.left - Standard.myInset.right - Standard.padding
    let myHeight = contentView.frame.height - categoryImageView.frame.height - Standard.myInset.top - Standard.myInset.bottom
    
    return CGSize(width: myWidth, height: myHeight)
  }
}
