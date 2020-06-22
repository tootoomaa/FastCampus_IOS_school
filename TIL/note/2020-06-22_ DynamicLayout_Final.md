# Dynamic AutoLayout 풀이



### NameWSViewController.swift

- xf symbol 에서 가져온 이미지에 대해서 크기 조절이 가능

  - small / medium / large

  - ```swift
    button.setPreferredSymbolConfiguration(.init(scale: .medium), forImageIn: .normal)
    ```



- AttributedPlaceholder

  - **텍스트 필드의 일부 속성들 제거**

  - ```swift
    private let wsNameTextField: UITextField = {
      let textField = UITextField()
      let attrString = NSAttributedString(
        string: "Name your workspace",
        attributes: [.foregroundColor: UIColor.darkText.withAlphaComponent(0.5)]
      )
      // 단순한 placehonder 가 아닌 텍스트 속성 추가
      textField.attributedPlaceholder = attrString
      textField.font = UIFont.systemFont(ofSize: 22, weight: .light)
      textField.enablesReturnKeyAutomatically = true // 사용자가 입력하는 순간 return 활성화
      textField.borderStyle = .none
      textField.returnKeyType = .go 	//  continue, go, done 등 변경 가능
      textField.autocorrectionType = .no	// 자동수정
      textField.autocapitalizationType = .none
      return textField
    }()
    ```

-   **사용자가 입력할때 나타는 텍스트 라벨 설정 확인**

  - ```swift
     private let floatingLabel: UILabel = {
         let label = UILabel()
         label.text = "Name your workspace"
         label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
         label.alpha = 0.0
         return label
       }()
    private var floatingCenterYConst: NSLayoutConstraint! // 이동시 적용할 변수 생성
    ```

-  **사용자 입력시 나타나는 텍스트 라벨이 뒤로 나오도록 하는**

  - priority를 이용하여 우선순위를 통해 위아래로 이동하도록 적용

  - ```swift
    /*
    defaultCenterY는 우선순위 500으로 고정하고
    floatingCenterY 제약만 우선순위 250, 750으로 변경하면서 애니메이션 처리
    */
    let defaultCenterYConst = floatingLabel.centerYAnchor.constraint(equalTo: wsNameTextField.centerYAnchor)
    defaultCenterYConst.priority = UILayoutPriority(500)
    defaultCenterYConst.isActive = true
    
    floatingCenterYConst = floatingLabel.centerYAnchor.constraint(equalTo: wsNameTextField.centerYAnchor, constant: -30)
    floatingCenterYConst.priority = .defaultLow // 250
    floatingCenterYConst.isActive = true
    ```

- **사용자가 입력을 시작할때 변경되는 사항**

  - ``` swift
    // MARK: - UITextFieldDelegate
    extension NameWSViewController: UITextFieldDelegate {
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 사용자 입력이 완료되면 처리 되는 부분
        didTapNextButton(nextButton)
        return true
      }
    
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
    
        // 입력한 텍스트를 range와 string을 이용하여
        // 복사 붙혀넣기 하거나 블럭값으로 넣고 뺄때. range 값을 이용해야한다.
        let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
        nextButton.isSelected = !replacedText.isEmpty
    		// 에니메이션 설정
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
          if replacedText.isEmpty {
            // 아래로 내려줌
            self.floatingCenterYConst.priority = .defaultLow	// 움직일 라벨의 우선수위 변경 (250)
            self.floatingLabel.alpha = 0.0	// 숨김
          } else {
            // 위로 올려줌
            self.floatingCenterYConst.priority = .defaultHigh	// 움직일 라벨의 우선수위 변경 (750)
            self.floatingLabel.alpha = 1.0
          }
          //  에니메이션 실행시 반듯이 진행해햐 할 사항
          self.view.layoutIfNeeded()
        })
        return true
      }
    }
    ```

- **진동 관련 부분**

  - 관련 속성

    -  ```swift
      import AudioToolbox.AudioServices
       ```

      

  - 관련 함수

    - ```swift
      private func vibrate() {
        // 핸드폰 설정에서 진동을 꺼둔 상황엔 동작하지 않음.
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
      }
      
      ```

-  인디케이어 생성 및 관련 함수

  - 생성 함수

    - ```swift
      private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.hidesWhenStopped = true
        return indicatorView
      }()
      ```

  - 관련 함수

    - ``` swift
      // 사용자의 입력이 종료되어. Return 을 누루거나. Next누를때
      
      @objc private func didTapNextButton(_ sender: UIButton) {
          guard nextButton.isSelected, let text = wsNameTextField.text else { return vibrate() }
          guard !indicatorView.isAnimating else { return }
          
          let textSize = (text as NSString).size(withAttributes: [.font: wsNameTextField.font!])
          indicatorViewLeadingConst.constant = textSize.width + 8
          indicatorView.startAnimating()	//  에니메이션 추가 
          
        	// 병렬적으로 1분뒤에 에니메이션이 종료되고 다음 화면으로 넘어가기 위한 코드
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.indicatorView.stopAnimating() //  애니메이션 종료
            let vc = UrlWSViewController() // 다음 화면에 대한 인스턴스 생성
            vc.workspaceName = text				// 현재 화면의 text를 넘겨줌
            self.navigationController?.pushViewController(vc, animated: true)
          }
        }
      ```



#### UrlWSViewController.swift



- Next 버튼을 눌렀을때 입력값이 오류인 경우 해당 텍스트 필드를 흔들어주는 애니메이션

  - ```swift
    @objc private func didTapNextButton(_ sender: UIButton) {
      	// error 나 fail이 들어올 경우
        guard nextButton.isSelected, !["error", "fail"].contains(urlTextField.text!) else {
          shakeAnimation()	// 흔드는 모션 추가
          errorMessageLabel.isHidden = false
          AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
          return
        }
        print("didTapNextButton")
      }
    ```

  - ```swift
    private func shakeAnimation() {
      UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
          self.urlTextField.center.x -= 8
          self.placeholderLabel.center.x -= 8
        })
        UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
          self.urlTextField.center.x += 16
          self.placeholderLabel.center.x += 16
        })
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
          self.urlTextField.center.x -= 16
          self.placeholderLabel.center.x -= 16
        })
        UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
          self.urlTextField.center.x += 8
          self.placeholderLabel.center.x += 8
        })
      })
    }
    
    ```

-  textField 에 입력된 텍스트의 길이를 구하는 방법

  - ```swift
    guard replacedText.count <= 20 else { return false }
    let textFieldAttr = [NSAttributedString.Key.font: textField.font!]
    let textWidthSize = (replacedText as NSString).size(withAttributes: textFieldAttr).width
    placeholderLeadingConst.constant = textWidthSize
    ```