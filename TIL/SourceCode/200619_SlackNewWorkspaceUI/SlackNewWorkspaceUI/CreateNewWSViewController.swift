//
//  ViewController.swift
//  SlackNewWorkspaceUI
//
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class CreateNewWSViewController: UIViewController {

  //MARK: - Properties
  let stringButtom:UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("Create New Workspace", for: .normal)
    bt.titleLabel?.font = .systemFont(ofSize: 20)
    bt.addTarget(self, action: #selector(tabStringButton), for: .touchUpInside)
    
    return bt
  }()
  
  //MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    // 오토레아아웃 구성
    view.addSubview(stringButtom)
    stringButtom.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stringButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stringButtom.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -50)
    ])
  }
  
  //MARK: - buttonAction
  @objc func tabStringButton() {
    
    let nameWSVC = NameWSViewController()
    nameWSVC.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(nameWSVC, animated: true)

  }
}
