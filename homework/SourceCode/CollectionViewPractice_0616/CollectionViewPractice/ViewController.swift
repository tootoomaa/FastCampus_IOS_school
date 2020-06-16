//
//  ViewController.swift
//  CollectionViewPractice
//
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit


private let reuseableId = "Cell"

final class ViewController: UIViewController {
  
  //MARK: - Properties
  lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
  
  var imageArray:[String] = []
  var enableDelete:Bool = false
  var deleteItemList:[IndexPath] = []

  var itemCount = 20
  
  struct UI {
    static let viewImageCount:CGFloat = 10
    static let lineSpacing:CGFloat = 40 / viewImageCount
    static let itemSpacing:CGFloat = 40 / viewImageCount
    static let sectionInset:CGFloat = 40 / viewImageCount
  }

  
  // MARK: LifeCycle
  
  fileprivate func collectionVeiwLayout() {
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidth = (view.frame.size.width - UI.itemSpacing*(UI.viewImageCount-1) - UI.sectionInset*2)/UI.viewImageCount
    
    layout.minimumLineSpacing = CGFloat(UI.lineSpacing)
    layout.minimumInteritemSpacing = UI.itemSpacing
    layout.sectionInset = UIEdgeInsets(top: UI.sectionInset, left: UI.sectionInset, bottom: UI.sectionInset, right: UI.sectionInset)
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
  }
  
  fileprivate func collectionViewSetting() {
    collectionView.dataSource = self
//    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: reuseableId)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseableId)
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
    
  }
  
  //MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    makeStringArray()
    
    navigationItem.title = "CollectonView"
    
    collectionVeiwLayout()
    
    collectionViewSetting()
    
    view.addSubview(collectionView)
    
  }
  
  // MARK: Action
  @IBAction func tabDeleteAction(_ sender: Any) {
    if !deleteItemList.isEmpty {
      print(deleteItemList.sorted(by:>))
      for indexPath in deleteItemList.sorted(by:>) {
        imageArray.remove(at: indexPath.row)
      }
      collectionView.deleteItems(at: deleteItemList)
    }
    // 배열이 비었을 경우 초기화
    print(imageArray)
    if imageArray.isEmpty {
      makeStringArray()
    }
    deleteItemList = []
    collectionView.reloadData()
  }
  
  func makeStringArray() {
    for _ in 0..<2 {
      for i in 0..<10 {
        imageArray.append("cat\(i)")
      }
    }
  }
  
}


// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print(indexPath)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseableId, for: indexPath)
    let imageView = UIImageView(image: UIImage(named: imageArray[indexPath.item]), highlightedImage: UIImage(systemName: "checkmark.circle.fill"))
    imageView.frame = cell.contentView.frame
    cell.contentView.addSubview(imageView)
    cell.contentView.backgroundColor = .blue
    cell.isMultipleTouchEnabled = true
    if deleteItemList.contains(indexPath) {
      cell.isHighlighted = true
    } else {
      cell.isHighlighted = false
    }
    return cell
  }
  
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("select")
    guard let cell = collectionView.cellForItem(at: indexPath) else {return}
    cell.isHighlighted.toggle()
    
    if !deleteItemList.contains(indexPath) {
      deleteItemList.append(indexPath)
      print(deleteItemList)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    print("deSelect")
  }
}
