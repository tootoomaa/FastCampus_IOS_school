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
  
  var imageNameArray:[String] = []
  var catArray:[String] = []
  
  var enableDelete:Bool = false
  var deleteItemList:[IndexPath] = []

  // 총 나타낼 이미지의 갯수
  var itemCount = 20
  
  // UI 관련한 크기 설정 설정부분
  struct UI {
    static let viewImageCount:CGFloat = 2
    static let lineSpacing:CGFloat = 40 / viewImageCount
    static let itemSpacing:CGFloat = 40 / viewImageCount
    static let sectionInset:CGFloat = 40 / viewImageCount
  }

  
  // MARK: configure UI
  
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
    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: reuseableId)
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
    view.addSubview(collectionView)
  }
  
  //MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "CollectonView"
    
    // 이미지 데이터 생성
    makeStringArray()
    
    collectionVeiwLayout()
    
    collectionViewSetting()
    
  }
  
  // MARK: Action
  @IBAction func tabDeleteAction(_ sender: Any) {
    // 사용자가 선택한 사진들의 배열을 받아옴
    if !deleteItemList.isEmpty {
      // indexPath.item수가 큰 이미지부터 제거
      for indexPath in deleteItemList.sorted(by:>) {
        // 이미지 배열에서 제거
        imageNameArray.remove(at: indexPath.item)
        catArray.remove(at: indexPath.item)
      }
      // collection View에서 제거
      collectionView.deleteItems(at: deleteItemList)
      deleteItemList = []
    }
    
    // 배열이 비었을 경우 초기화
    print(imageNameArray)
    if imageNameArray.isEmpty {
      makeStringArray()
      collectionView.reloadData()
    }
    
  }
  
  func makeStringArray() {
    for k in 0..<20 {
      imageNameArray.append("cat\(k%10)")
      catArray.append("cat\(k)")
    }
  }
}


// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageNameArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseableId, for: indexPath) as! CustomCell
    
    cell.imageView.image = UIImage(named: imageNameArray[indexPath.row])
    
    cell.checkView.isHidden = deleteItemList.contains(indexPath) ? false : true
    cell.imageView.alpha = cell.checkView.isHidden ? 1 : 0.5
    
    return cell
  }
}

 //MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCell else {return}
    
    // cell에 체크이미지를 표기하기 위한 조치
    cell.checkView.isHidden.toggle()
    cell.imageView.alpha = cell.checkView.isHidden ? 1 : 0.5
    
    // 사용자가 체크한 이미지가 배열에 없으면 추가, 있으면 삭제
    if !deleteItemList.contains(indexPath) {
      deleteItemList.append(indexPath)
    } else {
      guard let index = deleteItemList.firstIndex(of: indexPath) else { return }
      deleteItemList.remove(at: index)
    }
    
  }

}
