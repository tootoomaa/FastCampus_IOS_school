//
//  MainVCViewController.swift
//  LoginPage_200514
//
//  Created by 김광수 on 2020/05/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var newUserId: String = ""
    
    struct SavedUserData {
        static var mainview = "mainview"
        static var loginStatus = "loginstatus"
        static var userName = "username"
    }
    
    let userIdLabelL: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    let LogoutButton: UIButton = {
        var bt = UIButton()
        bt.backgroundColor = .gray
        bt.setTitle("Logout", for: .normal)
//        bt.titleLabel?.font = .systemFont(ofSize: 25)
        return bt
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let username = UserDefaults.standard.string(forKey: SavedUserData.userName) {
            newUserId = username
        }
        
        userIdLabelL.text = newUserId
        userIdLabelL.frame = CGRect(x: 50, y: 200, width: 200, height: 40)
        view.addSubview(userIdLabelL)
        
        LogoutButton.frame = CGRect(x: 50, y: 300, width: 100, height: 40)
        LogoutButton.addTarget(self, action: #selector(tabLogoutButton), for: .touchUpInside)
        view.addSubview(LogoutButton)
        
        view.backgroundColor = .white
        
        
    }
    
    @objc func tabLogoutButton(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: SavedUserData.loginStatus) {
            
            UserDefaults.standard.set("LoginVC", forKey: SavedUserData.mainview)
            UserDefaults.standard.set(nil ,forKey: SavedUserData.userName)
//            UserDefaults.standard.set(false ,forKey: SavedUserData.loginStatus)
            
            let loginView = LoginVC()
            loginView.modalPresentationStyle = .fullScreen
            present(loginView, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

