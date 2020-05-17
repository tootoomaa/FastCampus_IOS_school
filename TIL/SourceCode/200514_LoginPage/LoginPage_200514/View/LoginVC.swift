//
//  ViewController.swift
//  LoginPage_200514
//
//  Created by 김광수 on 2020/05/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit


var userDataDic = ["kks@gmail.com":"kkss"]

class LoginVC: UIViewController {
    
    struct SavedUserData {
        static var mainview = "mainview"
        static var loginStatus = "loginstatus"
        static var userName = "username"
    }
    
    let topDotOne: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        return view
    }()
    
    let topDotTwo: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        return view
    }()
    
    let topDotThree: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        return view
    }()
    let topLogoImage: UIImage = {
        var img = UIImage()
        img = UIImage(named: "fastcampus_logo@2x.png")!
        return img
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
        tf.isSecureTextEntry = true
        tf.alpha = 1
        return tf
    }()
    let loginButton: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .gray
        bt.layer.cornerRadius = 10
        bt.setTitle("Sign In", for: .normal)
        return bt
    }()
    let signUpButton: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .gray
        bt.layer.cornerRadius = 10
        bt.setTitle("Sign UP", for: .normal)
        return bt
    }()
    
    fileprivate func setBottonStackView() {
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
        
        //button View생성
        let SignInButtonView = UIView()
        loginButton.frame = CGRect(x: 0, y: 0, width: 230, height: 40)
        loginButton.addTarget(self, action: #selector(tabLoginButton), for: .touchUpInside)
//        signUpButton.frame = CGRect(x: 0, y: 45, width: 230, height: 40)
        signUpButton.addTarget(self, action: #selector(tabSingupButton), for: .touchUpInside)
        SignInButtonView.addSubview(loginButton)
        
        signUpButton.frame = CGRect(x: 70, y: 700, width: 230, height: 40)
               view.addSubview(signUpButton)
        
        //stackView
        let UserInputDatastackVeiw = UIStackView(arrangedSubviews: [userEmailInputView,UserPasswordInputView,SignInButtonView])
        
        UserInputDatastackVeiw.axis = .vertical
        UserInputDatastackVeiw.spacing = 30
        UserInputDatastackVeiw.distribution = .fillEqually
        UserInputDatastackVeiw.frame = CGRect(x: 70, y: 450, width: 230, height: 200)

        view.addSubview(UserInputDatastackVeiw)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        //textField delegate 처리를 위한 설정
        idTextField.delegate = self
        passwdTextField.delegate = self
        
        view.backgroundColor = .white
        
        let imageView = UIImageView(frame: CGRect(x: 40, y: 100, width: 270, height: 80))
        imageView.image = topLogoImage
        view.addSubview(imageView)
        
        let topDotStackView = UIStackView(arrangedSubviews: [topDotOne,topDotTwo,topDotThree])
    
        topDotStackView.axis = .horizontal
        topDotStackView.spacing = 10
        topDotStackView.distribution = .fillEqually
        topDotStackView.frame = CGRect(x: 130, y: 200, width: 90, height: 25)
        view.addSubview(topDotStackView)

        setBottonStackView()
        
        //키보드 내리는 notification 알림
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveUp), name: UIResponder.keyboardWillShowNotification, object: nil)
                
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func tabLoginButton(sender: UIButton) {
        //사용자 정보 입력이 잘못된 경우 아래와 같이 에니메이션 실행
        if idTextField.text == "" || passwdTextField.text == "" {
            UIView.animate(withDuration: 0.3) {
                self.idTextField.backgroundColor = .red
                self.passwdTextField.backgroundColor = .red
                self.idTextField.backgroundColor = .white
                self.passwdTextField.backgroundColor = .white
            }
        }
        
        guard let username = idTextField.text, let password = passwdTextField.text else  {return}
        // 사용자 정보 확인
        guard let passwd = userDataDic[username.lowercased()] else {
            // 패스워드 및 사용자 정보 오류기 알람 버튼
            let addAlertMenu = UIAlertController(title: "로그인 오류", message: "사용자 및 패스워드 를 확인하세요", preferredStyle: .alert)
            // alert 창의 "Cancle" 메뉴 누를 시
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                
            }
            
            //각 메뉴 alert창에 추가
            addAlertMenu.addAction(cancelAction)
            // 화면에 띄우기
            present(addAlertMenu, animated: true)
            
            return
        }
        // 패스워드 맞을시 로그인
        if password.lowercased() == passwd {
            
            let mainVC = MainVC()
            mainVC.newUserId = username
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true, completion: nil)
            
            idTextField.text = ""
            passwdTextField.text = ""
            
            let window = UIWindow()
            window.rootViewController = MainVC()
            //User Data Save
            UserDefaults.standard.set("MainVC", forKey: SavedUserData.mainview)
            UserDefaults.standard.set(username ,forKey: SavedUserData.userName)
            UserDefaults.standard.set(true ,forKey: SavedUserData.loginStatus)
        }
    }
    
    @objc func tabSingupButton(sender: UIButton) {
        let signupVC = SignupVC()
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true, completion: nil)
    }
}


//MARK: - UITextFieldDelegate

extension LoginVC: UITextFieldDelegate{
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
