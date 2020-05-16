//
//  SecondVC.swift
//  homework_2005013
//
//  Created by 김광수 on 2020/05/13.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

protocol SecondToFirstDelegate: class {
  func sendText() -> String
}


final class SecondVC: UIViewController {
    
      @IBOutlet private weak var displayLabel: UILabel!
      weak var delegate: SecondToFirstDelegate?
      var text: String?
      
      override func viewDidLoad() {
        super.viewDidLoad()

        let text = self.text ?? delegate?.sendText()
        displayLabel.text = text
      }
    }


    // MARK: - FirstToSecondDelegate

    extension SecondVC: FirstToSecondDelegate {
      func sendText(_ text: String) {
        self.text = text
      }
}
