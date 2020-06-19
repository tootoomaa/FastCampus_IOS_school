//
//  UrlWSViewController.swift
//  SlackNewWorkspaceUI
//
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class UrlWSViewController: UIViewController {
  
  var userName:String? {
    didSet {
      
      guard let userName = userName else { return }
      urlTextField.text = "\(userName)"
    }
  }
  
  let textLabel: UILabel = {
    let label = UILabel()
    label.text = "Get a URL (Letters, numbers, add dashes only"
    label.font = .boldSystemFont(ofSize: 15)
    return label
  }()
  
  let urlTextField: UITextField = {
    let tf = UITextField()
    tf.font = .systemFont(ofSize: 25)
    return tf
  }()
  
  
  let informationLabel: UILabel = {
    let label = UILabel()
    label.text = "This is the address that you'll use to sign in to Slack"
    label.font = .systemFont(ofSize: 15)
    label.textColor = .systemGray
    return label
  }()
  
  let followUrlLabel: UILabel = {
    let label = UILabel()
    label.text = ".slack.com"
    label.font = .systemFont(ofSize: 25)
//    label.backgroundColor = .red
    label.textColor = .systemGray3
    return label
  }()
  
  fileprivate func configureNavigationBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(tabBackButton))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: nil)
  }
  
  fileprivate func configureAutolayout() {
    view.addSubview(textLabel)
    view.addSubview(urlTextField)
    view.addSubview(informationLabel)
    view.addSubview(followUrlLabel)
    
    urlTextField.delegate = self
    
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    urlTextField.translatesAutoresizingMaskIntoConstraints = false
    informationLabel.translatesAutoresizingMaskIntoConstraints = false
    followUrlLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
      informationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
      informationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -20),
      
      urlTextField.leadingAnchor.constraint(equalTo: informationLabel.leadingAnchor),
      urlTextField.bottomAnchor.constraint(equalTo: informationLabel.topAnchor,constant: -100),
      
      textLabel.leadingAnchor.constraint(equalTo: informationLabel.leadingAnchor),
      textLabel.trailingAnchor.constraint(equalTo: informationLabel.trailingAnchor),
      textLabel.widthAnchor.constraint(equalTo: informationLabel.widthAnchor),
      textLabel.bottomAnchor.constraint(equalTo: urlTextField.topAnchor,constant: -5),
      
      followUrlLabel.leadingAnchor.constraint(equalTo: urlTextField.trailingAnchor),
      followUrlLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      followUrlLabel.centerYAnchor.constraint(equalTo: urlTextField.centerYAnchor)
      
    ])
  }
  
  //MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    configureNavigationBar()
    
    configureAutolayout()
    
  }
  
  @objc func tabBackButton() {
    navigationController?.popViewController(animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.urlTextField.becomeFirstResponder()
  }
}

extension UrlWSViewController: UITextFieldDelegate {
  
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newLength = (textField.text?.count)! + string.count - range.length
    
    // 글자수 제한
    if newLength > 16 {
      textField.text?.removeLast()
    }
    return !(newLength > 16)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.text == "Error" {
      let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)  // 원하는 스타일로 변경
      impactFeedbackGenerator.prepare()   // 진동 준비
      impactFeedbackGenerator.impactOccurred()   // 진동
    }
    return true
  }
}
