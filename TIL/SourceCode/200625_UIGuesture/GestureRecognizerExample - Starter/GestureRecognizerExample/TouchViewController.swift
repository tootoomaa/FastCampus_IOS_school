//
//  TouchViewController.swift
//  GestureRecognizerExample
//
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class TouchViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView! {
    didSet {
      imageView.layer.cornerRadius = imageView.bounds.width/2
      imageView.clipsToBounds = true
    }
  }
  
  var isHoldingImage = false
  var gapX:CGFloat = 0
  var gapY:CGFloat = 0
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    print("------ [Begin]-------")
    guard let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)
    
    if imageView.frame.contains(touchPoint) {
      imageView.image = UIImage(named: "cat2")
      gapX = imageView.center.x - touchPoint.x
      gapY = imageView.center.y - touchPoint.y
      isHoldingImage.toggle()
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    guard isHoldingImage, let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)
    print(touchPoint)
    if imageView.frame.contains(touchPoint) {
      imageView.center.x = touchPoint.x + gapX
      imageView.center.y = touchPoint.y + gapY
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard isHoldingImage else { return }
    imageView.image = UIImage(named: "cat1")
    gapY = 0
    gapX = 0
    isHoldingImage.toggle()
    
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    print("------ [cancel]-------")
    // 시스템이나 다른 방해(인터럽션) 상황으로 인해서 App이 inactive상태로 변경될떄
    // 터치 이벤트중이던 뷰가 사라지거나 다른 화면으로 전환 될 경우
    guard let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)
    guard isHoldingImage else { return }
  }
  
  
  override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionBegan(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat2")
    }
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionEnded(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat1")
    }
  }
  
  override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionCancelled(motion, with: event)
    if motion == .motionShake {
      imageView.image = UIImage(named: "cat1")
    }
  }
  
}



