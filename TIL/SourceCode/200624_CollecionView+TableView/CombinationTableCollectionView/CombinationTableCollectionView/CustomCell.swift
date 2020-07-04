//
//  CustomCell.swift
//  CombinationTableCollectionView
//
//  Created by 김광수 on 2020/06/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
  
  //MARK: - Properties
  
  static let identifier = "CellId"
  
  private let titleLabel = UILabel()
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
//    CGRect(x: 0, y: 0, width: 0, height: 0)
//    CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0))
    
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  private var carList = [String]()
  
  var offset: CGPoint {
    // set(value)
    set {
      collectionView.contentOffset = newValue
    }
    get {
      collectionView.contentOffset
    }
  }
  
  //MARK: -  Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUI()
    setConstraint()
  }
  
  required init?(coder: NSCoder) { // 스토리보드로 쓸때는 여기로 들어옴
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(data: [String:Any]) {
    titleLabel.text = data["브랜드"] as? String ?? "없음"
    carList = data["차종"] as? [String] ?? [String]()
    
    collectionView.reloadData()
  }
  
  private func setUI() {
    self.selectionStyle = .none
    
    titleLabel.textAlignment = .center
    titleLabel.backgroundColor = .darkGray
    titleLabel.textColor = .white
    titleLabel.font = .boldSystemFont(ofSize: 40)
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MyCellectionCell.self, forCellWithReuseIdentifier: MyCellectionCell.identifier)
    
  }
  
  struct Standard {
    static let space: CGFloat = 8
    static let inset: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
  }
  
  private func setConstraint() {
    [titleLabel,collectionView].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      
      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 240)
    ])
    
  }
  
}


extension CustomCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return carList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCellectionCell.identifier, for: indexPath) as? MyCellectionCell else { fatalError()}
    
    cell.backgroundColor = .red
    cell.titleLabel.text = carList[indexPath.item]
    
    return cell
  }
  
}

extension CustomCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Standard.space
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Standard.inset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = collectionView.frame.width - Standard.inset.left - Standard.inset
      .right - Standard.space
    let height = collectionView.frame.height - Standard.inset.top - Standard.inset.bottom
    
    return CGSize(width: width, height: height)
  }
  
}
