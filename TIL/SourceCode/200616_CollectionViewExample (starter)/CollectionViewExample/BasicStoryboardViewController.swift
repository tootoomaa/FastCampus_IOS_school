//
//  BasicStoryboardViewController.swift
//  CollectionViewExample
//
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class BasicStoryboardViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!
 
  let parkImages = ParkManager.imageNames(of: .nationalPark)
}


// MARK: - UICollectionViewDataSource

extension BasicStoryboardViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parkImages.count * 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for: indexPath)
    
    if let imageView = cell.contentView.subviews.first as? UIImageView {
      imageView.image = UIImage(named: parkImages[indexPath.item % parkImages.count])
      cell.layer.cornerRadius = cell.frame.width / 2
    }
    
    return cell
  }
}

