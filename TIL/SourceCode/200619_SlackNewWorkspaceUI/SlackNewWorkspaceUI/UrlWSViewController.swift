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
    tf.textColor = .systemGray
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
    label.textColor = .systemGray3
    return label
  }()
  
  let errorLabel: UILabel = {
     let label = UILabel()
     label.text = "This URL is not available. Sorry!"
     label.font = .systemFont(ofSize: 15)
     label.textColor = .systemGray
    label.isHidden = true
     return label
   }()
  
  
  fileprivate func configureNavigationBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(tabBackButton))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action:#selector(tabNextButtom))
  }
  
  fileprivate func configureAutolayout() {
    view.addSubview(textLabel)
    view.addSubview(urlTextField)
    view.addSubview(informationLabel)
    view.addSubview(followUrlLabel)
    view.addSubview(errorLabel)
    
    urlTextField.delegate = self
    
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    urlTextField.translatesAutoresizingMaskIntoConstraints = false
    informationLabel.translatesAutoresizingMaskIntoConstraints = false
    followUrlLabel.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    
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
      followUrlLabel.centerYAnchor.constraint(equalTo: urlTextField.centerYAnchor),
      
      errorLabel.leadingAnchor.constraint(equalTo:urlTextField.leadingAnchor),
      errorLabel.topAnchor.constraint(equalTo:urlTextField.bottomAnchor, constant: 2),
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
  
  // Next버튼 눌렀을시 & 키보드 리턴 눌렀을시 처리 방법
  @objc func tabNextButtom() {
    userEndEditting()
    shakeAnimation()
  }
  
  private func shakeAnimation() {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.urlTextField.center.x -= 8
//        self.placeholderLabel.center.x -= 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.urlTextField.center.x += 16
//        self.placeholderLabel.center.x += 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.urlTextField.center.x -= 16
//        self.placeholderLabel.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.urlTextField.center.x += 8
//        self.placeholderLabel.center.x += 8
      })
    })
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.urlTextField.becomeFirstResponder()
  }
  
  func userEndEditting() {
    let text = urlTextField.text?.lowercased()
    if text == "error" || text == "fail"  {
      let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)  // 원하는 스타일로 변경
      impactFeedbackGenerator.prepare()   // 진동 준비
      impactFeedbackGenerator.impactOccurred()   // 진동
      errorLabel.isHidden = false // Error 라벨 표시
    }
  }
}

extension UrlWSViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newLength = (textField.text?.count)! + string.count - range.length
    
    // textField 를 다시 수정할 떄  ErrorLabel을 숨겨줌
    errorLabel.isHidden = true
    
    // Next 버튼 활성화&비활성화 제어
    navigationItem.rightBarButtonItem?.isEnabled = (newLength != 0 ? true : false)
    // 글자수 제한
    if newLength > 20 {
      textField.text?.removeLast()
      
    }
    return !(newLength > 20)
  }

  // return 버튼 눌렀을때 실행되는 부분
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    userEndEditting()
    return true
  }
}
