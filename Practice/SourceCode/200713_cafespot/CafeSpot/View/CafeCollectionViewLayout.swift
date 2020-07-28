//
//  CafeCollectionViewFlowLayout.swift
//  CafeSpot
//
//  Created by 김광수 on 2020/07/11.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit


protocol CafeCollectionViewLayoutDelegate: class {
  func cafeCollectionView(_ collectionView: UICollectionView, layout collectionViewLayout:CafeCollectionViewLayout, sizeForCafeAt indexPath: IndexPath) -> CGSize
}

final class CafeCollectionViewLayout: UICollectionViewLayout {
 
  struct Layout {
    let numberOfColumns: Int
    let itemSize: CGSize
    let lineSpacing: CGFloat
    let interItemSpacing: CGFloat

    static let `default` = Layout(
      numberOfColumns: 2,
      itemSize: CGSize(width: 160, height: 120),
      lineSpacing: 10,
      interItemSpacing: 10
    )
  }
  
  var layout: Layout = .default
  
  weak var delegate: CafeCollectionViewLayoutDelegate!
  
  private var layoutAttribute: [UICollectionViewLayoutAttributes] = []
  private var contentHeight: CGFloat = 0
  private var contentWidth: CGFloat {
    guard let cv = collectionView else { return 0 }
    
    let horizenalContentInset = cv.contentInset.left + cv.contentInset.right
    
    // collection뷰 내에 실제. content 의 크기를 고려하여 지정
    return cv.bounds.width - horizenalContentInset
  }
  
  override func invalidateLayout() {
    super.invalidateLayout()
    layoutAttribute.removeAll()
  }
  
  // 1단계 Propare
  override func prepare() {
    guard let collectionView = collectionView, layoutAttribute.isEmpty else { return }
    
    let columsCount = layout.numberOfColumns
    let totalItemSpacing = CGFloat(columsCount-1) * layout.interItemSpacing
    let cellWidth = (contentWidth - totalItemSpacing) / CGFloat(columsCount)
    
    var xOffset: [CGFloat] = []
    var yOffset: [CGFloat] = Array(repeating: 0, count: columsCount)
    
    for column in 0..<columsCount {
      let startOffset = CGFloat(column) * (cellWidth + layout.interItemSpacing)
      xOffset.append(startOffset)
    }
    
    let numberOfItem = collectionView.numberOfItems(inSection: 0)
    var columIndex = 0
    
    for item in 0..<numberOfItem {
      let indexPath = IndexPath(item: item, section: 0)
      let photoSize = delegate.cafeCollectionView(collectionView, layout: self, sizeForCafeAt: indexPath)
      let ratio = photoSize.width / cellWidth
      let cellHeight = (photoSize.height) / ratio
      
      let minYOffet = yOffset.min() ?? 0
      columIndex = yOffset.firstIndex(of: minYOffet) ?? 0
      
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = CGRect(
        x: xOffset[columIndex], y: yOffset[columIndex],
        width: cellWidth, height: cellHeight
      )
      layoutAttribute.append(attributes)
      
      yOffset[columIndex] += cellHeight + layout.lineSpacing
    }
    
    self.contentHeight = (yOffset.max() ?? 0) - layout.lineSpacing
  }
  
  // 2 단계 - colletionView contentSize
  override var collectionViewContentSize: CGSize {
    guard let  _ = collectionView else {return .zero}
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  // 3 단계 = layoutAttributesForElements(in rect:CGRect)
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return layoutAttribute.filter{ $0.frame.intersects(rect) }
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return layoutAttribute.first{ $0.indexPath == indexPath }
  }
}
