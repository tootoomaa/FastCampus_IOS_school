//
//  ViewController.swift
//  PopupButtonArray_200604
//
//  Created by 김광수 on 2020/06/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK: - Properties
  struct UI {
    var distanceButton:CGFloat = 100
    var buttonDistanceFromSide:CGFloat = 50
    var buttonWidth:CGFloat = 60
    var viewheight:CGFloat = UIScreen.main.bounds.size.height
    var viewWidth:CGFloat = UIScreen.main.bounds.size.width
  }
  
  let ui = UI()
  var buttonCount:Int = 0
  var mainButtonArray:[UIButton] = []
  var subButtonArray:[UIButton] = []
  
  lazy var mainButton:UIButton = {
    let bt = UIButton()
    bt.setTitle("버튼 0", for: .normal)
    bt.frame = CGRect(x: ui.buttonDistanceFromSide, y: ui.viewheight - 100, width: ui.buttonWidth, height: ui.buttonWidth)
    bt.backgroundColor = .red
    bt.layer.cornerRadius = ui.buttonWidth/2
    bt.isSelected = false
    bt.addTarget(self, action: #selector(tabMainButton), for: .touchUpInside)
    return bt
  }()
  
  lazy var subButton:UIButton = {
    let bt = UIButton()
    bt.setTitle("버튼 0", for: .normal)
    bt.frame = CGRect(x: ui.viewWidth - ui.buttonDistanceFromSide - ui.buttonWidth, y: ui.viewheight - 100, width: ui.buttonWidth, height: ui.buttonWidth)
    bt.backgroundColor = .red
    bt.layer.cornerRadius = ui.buttonWidth/2
    bt.isSelected = false
    bt.addTarget(self, action: #selector(tabSubButton), for: .touchUpInside)
    return bt
  }()
  
  
  //MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mainButtonArray.append(mainButton)
    subButtonArray.append(subButton)
    
    
    for number in 1..<5 {
      let button = makeMainButtonFunc(number: number)
      mainButtonArray.append(button)
      view.addSubview(button)
    }
    
    for number in 1..<5 {
      let button = makeSubButtonFunc(number: number)
      subButtonArray.append(button)
      view.addSubview(button)
    }
    
    view.addSubview(mainButton)
    view.addSubview(subButton)
  }
  
  //MARK: - Build UI
  func returnColorCode() -> CGFloat {
    guard let randomValue = (1...255).randomElement() else {return CGFloat(999)}
    return CGFloat(Double(randomValue)/255.0)
  }
  
  func makeMainButtonFunc(number:Int) -> UIButton {
    let bt = UIButton()
    bt.setTitle("버튼 \(number)", for: .normal)
    bt.frame = CGRect(x: ui.buttonDistanceFromSide, y: ui.viewheight - 100, width: ui.buttonWidth, height: ui.buttonWidth)
    bt.backgroundColor = UIColor(red: returnColorCode(), green: returnColorCode(), blue: returnColorCode(), alpha: 1)
    bt.layer.cornerRadius = ui.buttonWidth/2
    return bt
  }
  
  func makeSubButtonFunc(number:Int) -> UIButton {
     let bt = UIButton()
     bt.setTitle("버튼 \(number)", for: .normal)
     bt.frame = CGRect(x: ui.viewWidth - ui.buttonDistanceFromSide - ui.buttonWidth, y: ui.viewheight - 100, width: ui.buttonWidth, height: ui.buttonWidth)
      bt.backgroundColor = UIColor(red: returnColorCode(), green: returnColorCode(), blue: returnColorCode(), alpha: 1)
     bt.layer.cornerRadius = ui.buttonWidth/2
     return bt
   }
  
  //MARK: - Animation
  func dismissButtonAnimation(_ buttonArray:[UIButton]) {
    UIView.animateKeyframes(
      withDuration: 1,
      delay: 0,
      options: [.beginFromCurrentState],
      animations: {
        UIView.addKeyframe(
          withRelativeStartTime: 0, // 4 * 0
          relativeDuration: 0.25 // 4 * 025
        ) {
          for number in 1..<buttonArray.count {
            buttonArray[number].center.y += self.ui.distanceButton*CGFloat(number)
            buttonArray[number].transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
          }
        }
    })
  }
  
  func popupAnimation(_ buttonArray:[UIButton]) {
    print("action")
    UIView.animateKeyframes(
      withDuration: 1,
      delay: 0,
      options: [.beginFromCurrentState],
      animations: {
        UIView.addKeyframe(
          withRelativeStartTime: 0, // 4 * 0
          relativeDuration: 0.25 // 4 * 025
        ) {
          for number in 1..<buttonArray.count {
            buttonArray[number].center.y -= self.ui.distanceButton*CGFloat(number)
            buttonArray[number].transform = CGAffineTransform(scaleX: 1, y: 1)
          }
        }
    })
  }
  
  func subDismissButtonAnimation(_ buttonArray:[UIButton]) {
    UIView.animateKeyframes(
      withDuration: 1,
      delay: 0,
      options: [.beginFromCurrentState],
      animations: {
        for number in 1..<buttonArray.count {
          UIView.addKeyframe(
            withRelativeStartTime: 1 - 0.25*Double(number), // 4 * 0
            relativeDuration: 0.25*Double(number) // 4 * 025
          ) {
            buttonArray[number].center.y += self.ui.distanceButton*CGFloat(number)
            buttonArray[number].transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
          }
        }
      }
    )
  }
  
  func subPopupAnimation(_ buttonArray:[UIButton]) {
    UIView.animateKeyframes(
      withDuration: 1,
      delay: 0,
      options: [.beginFromCurrentState],
      animations: {
        for number in 1..<buttonArray.count {
          UIView.addKeyframe(
            withRelativeStartTime: 0, // 4 * 0
            relativeDuration: 0.25*Double(number) // 4 * 025
          ) {
            buttonArray[number].center.y -= self.ui.distanceButton*CGFloat(number)
            buttonArray[number].transform = CGAffineTransform(scaleX: 1, y: 1)
          }
        }
      }
    )
  }

  //MARK: - Button Action (Animation Start)
  @objc func tabMainButton(_ sender: UIButton) {
    if !sender.isSelected {
      popupAnimation(mainButtonArray)
    } else {
      dismissButtonAnimation(mainButtonArray)
    }
    sender.isSelected.toggle()
  }
  
  @objc func tabSubButton(_ sender: UIButton) {
    if !sender.isSelected {
      subPopupAnimation(subButtonArray)
    } else {
      subDismissButtonAnimation(subButtonArray)
    }
    sender.isSelected.toggle()
  }
}
