//
//  SignupVC.swift
//  LoginPage_200514
//
//  Created by 김광수 on 2020/05/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    
    let mainTopLabel: UILabel = {
        var label = UILabel()
        label.text = "Welcome Fastcaplus/n SignUp Page"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    let emailImgae: UIImage = {
        var img = UIImage(named: "email@2x.png")!
        return img
    }()
    let userImgae: UIImage = {
        var img = UIImage(named: "user@2x.png")!
        return img
    }()
    let passwdImgae: UIImage = {
        var img = UIImage(named: "password@2x.png")!
        return img
    }()
    
    let idTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "이메일을 입력하세요"
        tf.alpha = 1
        return tf
    }()
    let passwdTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "패스워드를 입력하세요"
        tf.alpha = 1
        tf.isSecureTextEntry = true
        return tf
    }()
    let cancelButton: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .gray
        bt.layer.cornerRadius = 10
        bt.setTitle("Cancel", for: .normal)
        return bt
    }()
    let signUpButton: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .gray
        bt.layer.cornerRadius = 10
        bt.setTitle("Sign UP", for: .normal)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //textField delegate 처리를 위한 설정
        idTextField.delegate = self
        passwdTextField.delegate = self
        
        //Top label
        mainTopLabel.frame = CGRect(x: 45, y: 100, width: 300, height: 80)
        view.addSubview(mainTopLabel)
        
        // User Eamil Input View
        let emailView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        emailView.image = emailImgae
        
        idTextField.frame = CGRect(x: 60, y: 0, width: 160, height: 40)
        
        let eamilInputBottomLine = UIView(frame: CGRect(x: 60, y: 44, width: 160, height: 2))
        eamilInputBottomLine.backgroundColor = .systemGray
        
        let userEmailInputView = UIView()
        userEmailInputView.addSubview(emailView)
        userEmailInputView.addSubview(idTextField)
        userEmailInputView.addSubview(eamilInputBottomLine)
        
        //User Password Input View
        let passwdView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        passwdView.image = passwdImgae
        
        passwdTextField.frame = CGRect(x: 60, y: 0, width: 160, height: 40)
        
        let passwordInputBottomLine = UIView(frame: CGRect(x: 60, y: 44, width: 160, height: 2))
        passwordInputBottomLine.backgroundColor = .systemGray
        
        let UserPasswordInputView = UIView()
        UserPasswordInputView.addSubview(passwdTextField)
        UserPasswordInputView.addSubview(passwdView)
        UserPasswordInputView.addSubview(passwordInputBottomLine)
        
        // bottom button
        let buttonView = UIView()
        cancelButton.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
        cancelButton.addTarget(self, action: #selector(tabCancelButton), for: .touchUpInside)
        signUpButton.frame = CGRect(x: 130, y: 0, width: 110, height: 40)
        signUpButton.addTarget(self, action: #selector(tabSignUpButton), for: .touchUpInside)
        buttonView.addSubview(cancelButton)
        buttonView.addSubview(signUpButton)
        
        //stackView
        let UserInputDatastackVeiw = UIStackView(arrangedSubviews: [userEmailInputView,UserPasswordInputView,buttonView])
        
        UserInputDatastackVeiw.axis = .vertical
        UserInputDatastackVeiw.spacing = 30
        UserInputDatastackVeiw.distribution = .fillEqually
        UserInputDatastackVeiw.frame = CGRect(x: 70, y: 450, width: 230, height: 250)
        
        view.addSubview(UserInputDatastackVeiw)
        
        //키보드 내리는 notification 알림
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //SignUp Page Cancle Button Action
    @objc func tabCancelButton(_ sender: Any) {
        let addAlertMenu = UIAlertController(title: "입력 취소", message: "정말 취소하시겠습니까?", preferredStyle: .alert)
        
        // alert 창의 "ok 메뉴 누를 시
        let addAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        // alert 창의 "Cancle" 메뉴 누를 시
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        //각 메뉴 alert창에 추가
        addAlertMenu.addAction(addAction)
        addAlertMenu.addAction(cancelAction)
        
        // 화면에 띄우기
        present(addAlertMenu, animated: true)
    }
    
    //SignUp Page SignUp Button Action
    @objc func tabSignUpButton(_ sender: Any) {
        let addAlertMenu = UIAlertController(title: "회원 가입", message: "회원 가입을 완료하시겠습니까?", preferredStyle: .alert)
        
        // alert 창의 "ok 메뉴 누를 시
        let addAction = UIAlertAction(title: "OK", style: .default) { _ in
            // 사용자의 입력 정보 확인
        guard let userId = self.idTextField.text,
            let password = self.passwdTextField.text else {return}
        
        if userId.count < 4 || password.count < 4 {
            let idCountError = UIAlertController(title: "아이디, 패스워드 오류", message: "4글자 이상 입력 부탁드립니다.", preferredStyle: .alert)
            let idCheckAction = UIAlertAction(title: "확인", style: .default) { _ in
            
            }
            idCountError.addAction(idCheckAction)
            self.present(idCountError, animated: true, completion: nil)
        }
            else if userDataDic[userId.lowercased()] == nil { // 회원가입 성공
                userDataDic[userId.lowercased()] = password.lowercased()
                let successSignupAlert = UIAlertController(title: "회원 가입 성공", message: "회원가입이 성공하였습니다. 로그인 부탁드립니다.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default) { _ in
                    // 로그인 페이지로 이동
                    self.dismiss(animated: true, completion: nil)
                }
                successSignupAlert.addAction(okButton)
                self.present(successSignupAlert, animated: true, completion: nil)
                
            } else {    // 회원 가입 실패
                let cancelSignupAlert = UIAlertController(title: "회원 가입 실패", message: "아이디가 이미 존제하거나, 올바르지 않은 아이디입니다.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                cancelSignupAlert.addAction(cancelAction)
                self.present(cancelSignupAlert, animated: true)
            }
        }
        // alert 창의 "Cancle" 메뉴 누를 시
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        //각 메뉴 alert창에 추가
        addAlertMenu.addAction(addAction)
        addAlertMenu.addAction(cancelAction)
        
        // 화면에 띄우기
        present(addAlertMenu, animated: true)

    }
}



extension SignupVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        if newLength > 16 {
            textField.text?.removeLast()
        }
        return !(newLength > 16)
    }
    
    //화면 터치하여 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func textViewMoveUp(_ notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
            })
        }
    }
    
    @objc func textViewMoveDown(_ notification: NSNotification){
        self.view.transform = .identity
    }
    
}
