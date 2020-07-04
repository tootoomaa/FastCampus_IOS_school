//
//  GestureViewController.swift
//  GestureRecognizerExample
//
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class GestureViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView! {
    didSet {
      imageView.layer.cornerRadius = imageView.frame.width / 2
      imageView.clipsToBounds = true
    }
  }
  var isQuardruple = false
  
  @IBAction private func handleTapGesture(_ sender: UITapGestureRecognizer) {
    guard sender.state == .ended else { return }
    print("tab")
    if !isQuardruple {
      imageView.transform = imageView.transform.scaledBy(x: 4, y: 4)
    } else {
      imageView.transform = .identity
    }
    isQuardruple.toggle()
  }
  
  @IBAction private func handleRotationGesture(_ sender: UIRotationGestureRecognizer) {
    print(sender.rotation)

    imageView.transform = imageView.transform.rotated(by: sender.rotation)
    sender.rotation = 0
//    imageView.transform = CGAffineTransform(rotationAngle: CGFloat(sender.rotation * 100 * .pi/180))
  }
  
  
  // MARK: Swipe
  @IBAction private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
    guard sender.state == .ended else {return}
    print(sender.direction.rawValue)
    
    if sender.direction == .left {
      imageView.image = UIImage(named: "cat2")
      sender.direction = .right
  
    } else {
      imageView.image = UIImage(named: "cat1")
      sender.direction = .left
    }
  }
}
